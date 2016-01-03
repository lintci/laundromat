module Github
  class Client
    delegate :emails, :create_pull_request_comment,
             :add_deploy_key, :remove_deploy_key,
             :create_hook, :remove_hook, :hooks,
             :update_team, :add_team_repository, :remove_team_repository,
             :update_organization_membership,
             :add_team_membership, :remove_team_membership,
             :deploy_keys, to: :octokit

    def initialize(*args)
      @octokit = Octokit::Client.new(*args)
    end

    def exchange_code_for_token(authorization_code)
      Github::AccessToken.from_api(octokit.exchange_code_for_token(authorization_code))
    rescue Octokit::Unauthorized
      nil
    end

    def user
      Github::User.from_api(octokit.user)
    end

    def repositories
      options = {accept: 'application/vnd.github.moondragon+json'} # Return org and user repos
      octokit.repositories(nil, options).map do |repository|
        Github::Repository.from_api(repository)
      end
    end

    def repository_teams(repository_name)
      octokit.repository_teams(repository_name).map do |data|
        Github::Team.from_api(data)
      end
    end

    def user_teams
      octokit.user_teams.map do |data|
        Github::Team.from_api(data)
      end
    end

    def org_teams(org_name)
      octokit.org_teams(org_name).map do |data|
        Github::Team.from_api(data)
      end
    end

    def team(id)
      Github::Team.from_api(octokit.team(id))
    end

    def create_team(owner_name, options)
      Github::Team.from_api(octokit.create_team(owner_name, options))
    end

    def collaborators(repository_name)
      octokit.collaborators(repository_name, accept: 'application/vnd.github.ironman-preview+json')
    end

    def add_collaborator(repository_name, username)
      octokit.add_collaborator(repository_name, username, accept: 'application/vnd.github.ironman-preview+json')
    end

    def remove_collaborator(repository_name, username)
      octokit.remove_collaborator(repository_name, username, accept: 'application/vnd.github.ironman-preview+json')
    end

  protected

    attr_reader :octokit
  end
end
