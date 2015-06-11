require 'spec_helper'

describe AccessToken, type: :model do
  describe '#valid?' do
    let(:existing_token){build(:access_token, access_token: '1')}
    subject(:token){build(:access_token, access_token: '1')}

    it 'requires user to be set' do
      token.user = nil

      expect(token).to_not be_valid
    end

    %i(access_token expires_at).each do |attribute|
      it "presets #{attribute}" do
        token.send(:"#{attribute}=", nil)

        expect(token).to be_valid
        expect(token.send(attribute)).to_not be_falsey
      end
    end

    it 'validates uniqueness of access_token' do
      existing_token.save

      expect(token).to_not be_valid
    end
  end

  describe '.from_authorization' do
    subject!(:token){create(:access_token, access_token: '1')}

    it 'looks up token from authorization' do
      expect(AccessToken.from_authorization('Bearer 1')).to eq(token)
    end
  end

  describe '#expires_in' do
    subject(:token){build(:access_token, expires_at: expires_at)}

    context 'when the time is in the past' do
      let(:expires_at){3.days.ago}

      it 'returns 0' do
        expect(token.expires_in).to eq(0)
      end
    end

    context 'when the time is in the future' do
      let(:expires_at){3.days.from_now}

      it 'returns the seconds left till the token expires' do
        Timecop.freeze(Time.now) do
          expect(token.expires_in).to eq(3.days)
        end
      end
    end
  end
end
