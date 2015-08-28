module Github
  class API
    SERVICE_USERNAME = ENV.fetch('GITHUB_SERVICE_USER')
    SERVICE_TOKEN = ENV.fetch('GITHUB_SERVICE_TOKEN')
    CLIENT_ID = ENV.fetch('GITHUB_CLIENT_ID')
    CLIENT_SECRET = ENV.fetch('GITHUB_CLIENT_SECRET')

    class << self
      def service
        new(SERVICE_TOKEN)
      end
    end

    attr_reader :client

    def initialize(access_token = nil)
      @client = if access_token
        Octokit::Client.new(access_token: access_token, auto_paginate: true)
      else
        Octokit::Client.new(
          client_id: CLIENT_ID,
          client_secret: CLIENT_SECRET,
          auto_paginate: true
        )
      end
    end

    def access_token(authorization_code)
      Github::AccessToken.new(client.exchange_code_for_token(authorization_code))
    end

    def user
      user = client.user
      emails = client.emails if user.email.blank?

      Github::User.new(user, emails)
    end

    def repositories
      return to_enum(:repositories) unless block_given?

      options = {accept: 'application/vnd.github.moondragon+json'} # Return org and user repos
      client.repositories(nil, options).each do |repository|
        yield Github::Repository.new(repository)
      end
    end

    def comment_on_pull_request(pull_request, source_file, line, violations)
      client.create_pull_request_comment(
        pull_request.repo_full_name,
        pull_request.id,
        violations.map(&:message).join('<br>'),
        pull_request.head_sha,
        source_file.name,
        line
      )
    end

    def add_lintci_to_repository(repository)
      if repository.organization?
        team_api.add_team_membership(repository, SERVICE_USERNAME)
      else
        client.add_collaborator(repository.full_name, SERVICE_USERNAME)
      end
    end

    def remove_user_from_repository(repository)
      if repository.organization?
        team_api.remove_membership(repository, SERVICE_USERNAME)
      else
        client.remove_collaborator(repository.full_name, SERVICE_USERNAME)
      end
    end

    def add_deploy_key(repository)
      client.add_deploy_key(repository.full_name, 'LintCI', repository.public_key)
    end

  private

    def team_api
      TeamAPI.new(client, self.class.service.client)
    end
  end
end
