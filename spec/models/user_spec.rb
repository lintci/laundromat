require 'spec_helper'

describe User, type: :model do
  describe '#valid?' do
    let(:existing_user){build(:user, uid: '1')}
    subject(:user){build(:user, uid: '1')}

    %i(email provider uid username).each do |attribute|
      it "requires #{attribute} to be set" do
        user.send(:"#{attribute}=", nil)

        expect(user).to_not be_valid
      end
    end

    it 'validates uniqueness of uid and provider pair' do
      existing_user.save

      expect(user).to_not be_valid
    end
  end

  describe '.upsert_from_provider!' do
    let(:provider_user){build(:github_user)}

    context 'when user exists' do
      subject!(:user){create(:user, uid: provider_user.uid)}

      it 'returns the existing user' do
        expect do
          @user = User.upsert_from_provider!(provider_user)
        end.to_not change{User.count}

        expect(@user).to eq(user)
      end
    end

    context 'when user does not exist' do
      it 'creates a new user with the provided oauth details' do
        expect do
          @user = User.upsert_from_provider!(provider_user)
        end.to change{User.count}.by(1)

        expect(@user.uid).to eq(provider_user.uid)
        expect(@user.email).to eq(provider_user.email)
        expect(@user.username).to eq(provider_user.username)
        expect(@user.provider).to eq(provider_user.provider)
      end
    end
  end

  describe '#upsert_access_token_from_provider!' do
    context 'when a token exists' do
      subject!(:user){create(:user, :with_tokens)}
      let!(:existing_access_token){user.active_access_token}
      let!(:existing_provider_token){existing_access_token.provider_token}
      let(:new_provider_token){existing_provider_token.succ}
      let(:provider_access_token){build(:github_access_token, access_token: new_provider_token)}

      it 'updates the token' do
        expect do
          user.upsert_access_token_from_provider!(provider_access_token)
          existing_access_token.reload
        end.to change{existing_access_token.provider_token}.from(existing_provider_token).to(new_provider_token)
      end
    end

    context 'when a token does not exist' do
      subject!(:user){create(:user)}
      let(:provider_access_token){build(:github_access_token, access_token: '1')}

      it 'creates a token with the provider access token' do
        expect do
          @token = user.upsert_access_token_from_provider!(provider_access_token)
        end.to change{AccessToken.count}.by(1)

        expect(@token).to have_attributes(
          user: user,
          provider_token: '1'
        )
      end
    end
  end

  describe '#access_token' do
    subject(:user){create(:user, :with_tokens)}

    it 'returns the active token' do
      old_token, current_token = user.access_tokens.sort_by(&:expires_at)

      expect(user.active_access_token).to eq(current_token)
      expect(user.active_access_token).to_not eq(old_token)
    end
  end
end
