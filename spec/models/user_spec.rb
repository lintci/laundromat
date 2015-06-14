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

  describe '.find_or_create_from_oauth' do
    let(:uid){'1'}
    let(:email){'bob@gmail.com'}
    let(:login){'bob'}
    let(:oauth){double('oauth', id: uid, email: email, login: login)}

    context 'when user exists' do
      subject!(:user){create(:user, uid: uid)}

      it 'returns the existing user' do
        expect do
          @user = User.find_or_create_from_oauth(oauth)
        end.to_not change{User.count}

        expect(@user).to eq(user)
      end
    end

    context 'when user does not exist' do
      it 'creates a new user with the provided oauth details' do
        expect do
          @user = User.find_or_create_from_oauth(oauth)
        end.to change{User.count}.by(1)

        expect(@user.uid).to eq(uid)
        expect(@user.email).to eq(email)
        expect(@user.username).to eq(login)
        expect(@user.provider).to eq(Provider[:github])
      end
    end
  end

  describe '#access_token' do
    subject(:user){create(:user, :with_tokens)}

    it 'returns the active token' do
      old_token, current_token = user.access_tokens.sort_by(&:expires_at)

      expect(user.access_token).to eq(current_token)
      expect(user.access_token).to_not eq(old_token)
    end
  end
end
