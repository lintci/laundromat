require 'spec_helper'

RSpec::Matchers.define :have_collaborator do |username|
  match do |collaborators|
    collaborators.any?{|collaborator| collaborator.login == username}
  end
end

describe Github::API do
  subject(:api){described_class.new(ENV.fetch('GITHUB_USER_ACCESS_TOKEN'))}
  let(:service_username){Github::API::SERVICE_USERNAME}

  # These handle both scenarios to ensure cleanup always happens
  describe '#add_lintci_to_repository/#remove_lintci_from_repository' do
    context 'when repository is private', :vcr do
      let(:repository){build(:owner_repository, private: true)}

      it 'adds/removes collaborator, hook, and deploy key' do
        aggregate_failures('LintCI not setup') do
          expect(api.client.collaborators(repository.full_name)).to_not have_collaborator(service_username)
          expect(api.client.deploy_keys(repository.full_name)).to be_empty
          expect(api.client.hooks(repository.full_name)).to be_empty
        end

        api.add_lintci_to_repository(repository, repository.build_activation)

        activation = repository.activation
        aggregate_failures('LintCI setup') do
          expect(activation.deploy_key_id).to match(/\d+/)
          expect(activation.webhook_id).to match(/\d+/)

          expect(api.client.collaborators(repository.full_name)).to have_collaborator(service_username)
        end

        api.remove_lintci_from_repository(repository, activation)

        aggregate_failures('LintCI torn down') do
          expect(api.client.collaborators(repository.full_name)).to_not have_collaborator(service_username)
          expect(api.client.deploy_keys(repository.full_name)).to be_empty
          expect(api.client.hooks(repository.full_name)).to be_empty
        end
      end
    end

    context 'when repository is public', :vcr do
      let(:repository){build(:owner_repository, private: false)}

      it 'adds/removes hook and deploy key, but no collaborator' do
        aggregate_failures('LintCI not setup') do
          expect(api.client.collaborators(repository.full_name)).to_not have_collaborator(service_username)
          expect(api.client.deploy_keys(repository.full_name)).to be_empty
          expect(api.client.hooks(repository.full_name)).to be_empty
        end

        api.add_lintci_to_repository(repository, repository.build_activation)

        activation = repository.activation
        aggregate_failures('LintCI setup') do
          expect(activation.deploy_key_id).to match(/\d+/)
          expect(activation.webhook_id).to match(/\d+/)

          expect(api.client.collaborators(repository.full_name)).to_not have_collaborator(service_username)
        end

        api.remove_lintci_from_repository(repository, activation)

        aggregate_failures('LintCI torn down') do
          expect(api.client.collaborators(repository.full_name)).to_not have_collaborator(service_username)
          expect(api.client.deploy_keys(repository.full_name)).to be_empty
          expect(api.client.hooks(repository.full_name)).to be_empty
        end
      end
    end
  end
end
