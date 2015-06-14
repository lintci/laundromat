require 'spec_helper'

describe AuthenticateGithubUser do
  describe '#call', :vcr do
    subject(:service){AuthenticateGithubUser.new(ENV['GITHUB_OAUTH_TOKEN'])}

    it 'authenticates against github and creates a user and token' do
      service.success do |token|
        user = token.user
        expect(user.username).to eq('blatyo')
        expect(user.email).to eq('blatyo@gmail.com')
        expect(user.uid).to eq('71221')
        expect(user.provider).to eq(Provider[:github])
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
