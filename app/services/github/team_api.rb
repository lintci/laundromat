module Github
  class TeamAPI
    TEAM = ENV.fetch('SERVICE_TEAM')

    def initialize(client, service_client)
      @client, @service_client = client, service_client
    end

    def add_team_membership(repository, username)
      team = find_team_with_admin_access(repository) ||
             find_and_update_lintci_team(repository) ||
             create_lintci_team(repository)

      join_team(team, username, repository.owner_name)
    end

    def remove_membership(repository, username)
      return unless (team = find_team(repository))

      client.remove_team_membership(team.id, username)
    end

  protected

    attr_reader :client, :service_client

  private

    def find_team_with_admin_access(repository)
      repo_teams = client.repository_teams(repository.full_name)
      admin_team_ids = client.user_teams.select{|team| team.permission == 'admin'}.map(&:id)

      repo_teams.find do |repo_team|
        admin_team_ids.include?(repo_team.id)
      end
    end

    def find_and_update_lintci_team(repository)
      team = find_lintci_team(repository)

      update_lintci_team(team, repository)

      team
    end

    def find_lintci_team(repository)
      client.org_teams(repository.owner_name).find do |team|
        team.name.downcase == TEAM.downcase
      end
    end

    def update_lintci_team(team, repository)
      return unless team

      client.update_team(team.id, permission: 'push') if team.permission == 'pull'
      client.add_team_repository(team.id, repository.full_name)
    end

    def create_lintci_team(repository)
      client.create_team(
        repository.owner_name,
        name: TEAM,
        repo_names: [repository.full_name],
        permission: 'push'
      )
    end

    def join_team(team, username, owner_name)
      client.add_team_membership(team.id, username)
      service_client.update_organization_membership(owner_name, state: 'active')
    end
  end
end
