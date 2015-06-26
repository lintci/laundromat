require 'spec_helper'

describe SyncRepositories do
  let(:access_token){create(:access_token, provider_token: ENV.fetch('GITHUB_USER_ACCESS_TOKEN'))}
  let(:user){create(:user, access_tokens: [access_token])}
  let(:provider){Provider[:github]}
  subject(:service){described_class}

  describe '#call', :vcr do
    it 'synchronizes users repositories and access' do
      service.call(provider.name, user.id)
    end
  end
end
