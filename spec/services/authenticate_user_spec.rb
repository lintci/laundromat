require 'spec_helper'

describe AuthenticateUser do
  describe '#call', :vcr do
    let(:provider){Provider[:github]}
    subject(:service){described_class.new(provider, ENV['GITHUB_OAUTH_TOKEN'])}

    it 'authenticates against github and creates a user and token' do
      service.success do |token|
        aggregate_failures do
          user = token.user
          expect(user.username).to eq('lexci-lint')
          expect(user.email).to eq('allen+lexci@lintci.com')
          expect(user.uid).to eq('12980159')
          expect(user.provider).to eq(provider)
        end
      end

      service.failure do |errors|
        raise errors.to_json
      end

      expect do
        expect do
          expect do
            service.call
          end.to change{User.count}.by(1)
        end.to change{AccessToken.count}.by(1)
      end.to change{SyncRepositoriesWorker.jobs.size}.by(1)
    end
  end
end
