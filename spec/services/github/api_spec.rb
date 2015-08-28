require 'spec_helper'

describe Github::API do
  subject(:api){described_class.new(ENV.fetch('GITHUB_USER_ACCESS_TOKEN'))}

  describe '#add_lintci_to_repository' do
    context 'when repository is an organization' do
      let(:repository){build(:owner_repository)}

      it 'delegates to the team api' do
        expect_any_instance_of(Github::TeamAPI).to receive(:add_team_membership).with(repository, Github::API::SERVICE_USERNAME)

        api.add_lintci_to_repository(repository)
      end
    end

    context 'when repository is not an organization', :vcr do
      let(:repository){build(:personal_repository)}
      let(:service_api){described_class.service}

      it 'adds LintCI as a collaborator' do
        api.add_lintci_to_repository(repository)

        expect(service_api.repositories).to satisfy do |repos|
          repos.any?{|repo| repo.name == repository.name && repo.access == RepositoryAccess::WRITE}
        end
      end
    end
  end
end
