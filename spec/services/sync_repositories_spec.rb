require 'spec_helper'

describe SyncRepositories do
  let(:access_token){create(:access_token, provider_token: ENV['GITHUB_USER_ACCESS_TOKEN'])}
  let(:user){create(:user, access_tokens: [access_token])}
  subject(:service){described_class}

  describe '#call', :vcr do
    it 'synchronizes users repositories and access' do
      expect(Pusher).to receive(:trigger).exactly(3).times.with(
        "private-user@#{user.id}",
        'data_updated',
        hash_including(:data)
      )

      expect do
        service.call(user.id)
      end.to change{user.repositories.count}.by(3)
    end
  end
end
