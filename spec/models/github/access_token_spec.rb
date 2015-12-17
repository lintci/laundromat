require 'spec_helper'

describe Github::AccessToken do
  describe '.from_api' do
    let(:api_access_token) do
      build(
        :sawyer_resource,
        data: {
          'access_token' => '92bc2774bdfc8e24c933758f5313ddb7aacbbe44',
          'token_type' => 'bearer',
          'scope' => 'repo,user:email'
        }
      )
    end
    subject(:provider_access_token){described_class.from_api(api_access_token)}

    it 'correctly constructs the provider token', :aggregate_failures do
      expect(subject.access_token).to eq('92bc2774bdfc8e24c933758f5313ddb7aacbbe44')
      expect(subject.scope).to eq('repo,user:email')
    end
  end
end
