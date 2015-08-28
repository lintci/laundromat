require 'spec_helper'

describe Github::TeamAPI do
  let(:client){Github::API.new(ENV.fetch('GITHUB_USER_ACCESS_TOKEN')).client}
  let(:service_api){Github::API.service}
  subject(:team_api){described_class.new(client, service_api.client)}

  describe '#add_team_membership' do
    context 'when user has access through team', :vcr do
      let(:repository){build(:admin_repository)}

      it 'adds LintCI to that team' do
        team_api.add_team_membership(repository, Github::API::SERVICE_USERNAME)

        expect(service_api.repositories).to satisfy do |repos|
          repos.any?{|repo| repo.full_name == repository.full_name && repo.access == RepositoryAccess::ADMIN}
        end
      end
    end

    context "when user is admin and team doesn't exist", :vcr do
      let(:repository){build(:owner_repository)}

      it 'creates the LintCI team, adds the repo, and LintCI user' do
        team_api.add_team_membership(repository, Github::API::SERVICE_USERNAME)

        expect(service_api.repositories).to satisfy do |repos|
          repos.any?{|repo| repo.full_name == repository.full_name && repo.access == RepositoryAccess::WRITE}
        end
      end
    end

    context 'when user is admin and team does exist', :vcr do
      # This depends on team having already been created outside test
      let(:repository){build(:owner2_repository)}

      it 'adds the repo to the LintCI team and fixes permissions' do
        team_api.add_team_membership(repository, Github::API::SERVICE_USERNAME)

        expect(service_api.repositories).to satisfy do |repos|
          repos.any?{|repo| repo.full_name == repository.full_name && repo.access == RepositoryAccess::WRITE}
        end
      end
    end
  end
end
