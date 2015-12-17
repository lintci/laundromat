require 'spec_helper'

RSpec::Matchers.define :contain_repository_with_write_access do |repository|
  match do |api|
    api.repositories.any? do |repo|
      repo.full_name == repository.full_name && repo.access == RepositoryAccess::WRITE
    end
  end
end

# Because these tests require setup outside on github, they assert that the initial
# conditions for the test are true.
describe Github::TeamAPI do
  let(:username){Github::API::SERVICE_USERNAME}
  let(:service_api){Github::API.service}
  subject(:team_api){Github::API.new(ENV.fetch('GITHUB_USER_ACCESS_TOKEN')).team_api}

  describe '#add_team_membership' do
    context 'when user has access through team', :vcr do
      let(:repository){build(:admin_repository)}

      it 'adds LintCI to that team' do
        expect(service_api).to_not contain_repository_with_write_access(repository)
        binding.pry
        team = team_api.add_team_membership(repository, username)

        expect(team).to have_attributes(name: 'admin', access: RepositoryAccess::ADMIN)
        expect(service_api).to contain_repository_with_write_access(repository)
      end
    end

    context "when user is admin and LintCI team doesn't exist", :vcr do
      let(:repository){build(:owner_repository)}

      it 'creates the LintCI team, adds the repo, and LintCI user' do
        expect(service_api).to_not contain_repository_with_write_access(repository)

        team = team_api.add_team_membership(repository, username)

        expect(team).to have_attributes(name: Github::Team::SERVICE_NAME, access: RepositoryAccess::ADMIN)
        expect(service_api).to contain_repository_with_write_access(repository)
      end
    end

    context 'when user is admin and LintCI team does exist', :vcr do
      # This depends on team having already been created outside test
      let(:repository){build(:owner2_repository)}

      it 'adds the repo to the LintCI team and fixes permissions' do
        expect(service_api).to_not contain_repository_with_write_access(repository)

        team = team_api.add_team_membership(repository, username)

        expect(team).to have_attributes(name: Github::Team::SERVICE_NAME, access: RepositoryAccess::ADMIN)
        expect(service_api).to contain_repository_with_write_access(repository)
      end
    end
  end

  describe '#remove_team_membership' do
    describe 'when the team is the LintCI team', :vcr do
      let(:repository){build(:owner_repository)}
      let(:team_id){''}

      it 'removes the repository from the team' do
        expect(service_api).to contain_repository_with_write_access(repository)

        team_api.remove_team_membership(repository, username, team_id)

        expect(service_api).to_not contain_repository_with_write_access(repository)
      end
    end

    describe 'when the team is not the LintCI team', :vcr do
      let(:repository){build(:admin_repository)}
      let(:team_id){''}

      it 'removes the LintCI user from the team' do
        expect(service_api).to contain_repository_with_write_access(repository)

        team_api.remove_team_membership(repository, username, team_id)

        expect(service_api).to_not contain_repository_with_write_access(repository)
      end
    end
  end
end
