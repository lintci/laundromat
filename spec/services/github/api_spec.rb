require 'spec_helper'

describe Github::API do
  subject(:api){described_class.new(ENV.fetch('GITHUB_USER_ACCESS_TOKEN'))}
  let(:octokit){Octokit::Client.new(access_token: ENV.fetch('GITHUB_USER_ACCESS_TOKEN'), auto_paginate: true)}

  describe '#add_lintci_to_repository' do
    context 'when repository is an organization and the user is the owner', :vcr do
      let(:repository){build(:owner_repository)}

      it 'delegates to the team api and adds a deploy key' do
        expect_any_instance_of(Github::TeamAPI).to receive(:add_team_membership).with(repository, Github::API::SERVICE_USERNAME)

        api.add_lintci_to_repository(repository)

        expect(octokit.deploy_keys(repository.full_name)).to satisfy do |keys|
          keys.any?{|key| key.title == 'LintCI'}
        end
      end
    end

    context 'when repository is an organization and the user is admin via a team', :vcr do
      let(:repository){build(:admin_repository)}

      it 'delegates to the team api and adds a deploy key' do
        expect_any_instance_of(Github::TeamAPI).to receive(:add_team_membership).with(repository, Github::API::SERVICE_USERNAME)

        api.add_lintci_to_repository(repository)

        expect(octokit.deploy_keys(repository.full_name)).to satisfy do |keys|
          keys.any?{|key| key.title == 'LintCI'}
        end
      end
    end

    context 'when repository is not an organization', :vcr do
      let(:repository){build(:personal_repository)}
      let(:service_api){described_class.service}

      it 'adds LintCI as a collaborator and adds a deploy key' do
        api.add_lintci_to_repository(repository)

        expect(service_api.repositories).to satisfy do |repos|
          repos.any?{|repo| repo.name == repository.name && repo.access == RepositoryAccess::WRITE}
        end

        expect(octokit.deploy_keys(repository.full_name)).to satisfy do |keys|
          keys.any?{|key| key.title == 'LintCI'}
        end
      end
    end
  end
end
