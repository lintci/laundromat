require 'spec_helper'

describe Github::API do
  subject(:api){described_class.new(ENV.fetch('GITHUB_USER_ACCESS_TOKEN'))}

  describe '#add_lintci_to_repository' do
    context 'when repository is an organization', :vcr do
      let(:repository){build(:owner_repository)}
      let(:team){build(:github_team)}

      it 'delegates to the team api and adds a deploy key', :aggregate_failures do
        expect_any_instance_of(Github::TeamAPI).to receive(:add_team_membership).with(repository, Github::API::SERVICE_USERNAME).and_return(team)

        api.add_lintci_to_repository(repository, repository.build_activation)

        activation = repository.activation
        expect(activation.team_id).to match(/\d+/)
        expect(activation.deploy_key_id).to match(/\d+/)
        expect(activation.webhook_id).to match(/\d+/)
      end
    end

    context 'when repository is not an organization', :vcr do
      let(:repository){build(:personal_repository)}
      let(:service_api){described_class.service}

      it 'adds LintCI as a collaborator and adds a deploy key', :aggregate_failures do
        api.add_lintci_to_repository(repository, repository.build_activation)

        activation = repository.activation
        expect(activation.team_id).to be_nil
        expect(activation.deploy_key_id).to match(/\d+/)
        expect(activation.webhook_id).to match(/\d+/)
      end
    end
  end

  xdescribe '#remove_lintci_from_repository' do
    context 'when repository is an organization', :vcr do
      let(:repository){build(:owner_repository)}

      it 'delegates to the team api and adds a deploy key' do
        expect_any_instance_of(Github::TeamAPI).to receive(:add_team_membership).with(repository, Github::API::SERVICE_USERNAME)

        api.remove_lintci_from_repository(repository)
      end
    end


    context 'when repository is not an organization', :vcr do
      let(:repository){build(:personal_repository)}
      let(:service_api){described_class.service}

      it 'adds LintCI as a collaborator and adds a deploy key' do
        api.remove_lintci_from_repository(repository)


      end
    end
  end
end
