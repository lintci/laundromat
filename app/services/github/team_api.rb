module Github
  class TeamAPI
    def initialize(client, service_client)
      @client, @service_client = client, service_client
    end

    def add_team_membership(repository, username)
      team = find_team_with_admin_access(repository) ||
             find_and_update_lintci_team(repository) ||
             create_lintci_team(repository)

      join_team(team, username, repository.owner_name)
    end

    def remove_team_membership(repository, username, team_id)
      return unless (team = find_team(team_id))

      if team.lintci?
        remove_repository_from_team(repository, team)
      else
        remove_lintci_from_team(username, team)
      end
    end

  protected

    attr_reader :client, :service_client

  private

    def find_team_with_admin_access(repository)
      repo_teams = client.repository_teams(repository.full_name).map{|data| Github::Team.from_api(data)}
      user_teams = client.user_teams.map{|data| Team.from_api(data)}
      admin_user_team_ids = user_teams.select(&:admin?)

      (repo_teams & admin_user_teams).first
    end

    def find_and_update_lintci_team(repository)
      team = find_lintci_team(repository)

      update_lintci_team(team, repository)

      team
    end

    def find_lintci_team(repository)
      client.org_teams(repository.owner_name).map{|data| Team.from_api(data)}.find(&:lintci?)
    end

    def find_team(team_id)
      Team.from_api(client.team(team_id))
    end

    def update_lintci_team(team, repository)
      return unless team

      client.update_team(team.id, permission: 'push') if team.permission == 'pull'
      client.add_team_repository(team.id, repository.full_name)
    end

    def create_lintci_team(repository)
      client.create_team(
        repository.owner_name,
        name: Team::SERVICE_NAME,
        repo_names: [repository.full_name],
        permission: 'push'
      )
    end

    def join_team(team, username, owner_name)
      client.add_team_membership(team.id, username)
      service_client.update_organization_membership(owner_name, state: 'active')

      team
    end

    def remove_repository_from_team(repository, team)
      client.remove_team_repository(team.id, repository.full_name)
    end

    def remove_lintci_from_team(username, team)
      client.remove_team_membership(team.id, username)
    end
  end
end
