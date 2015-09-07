module Github
  class API
    SERVICE_USERNAME = ENV.fetch('GITHUB_SERVICE_USER')
    SERVICE_TOKEN = ENV.fetch('GITHUB_SERVICE_TOKEN')
    CLIENT_ID = ENV.fetch('GITHUB_CLIENT_ID')
    CLIENT_SECRET = ENV.fetch('GITHUB_CLIENT_SECRET')
    PUSH_TO_START_URL = ENV.fetch('PUSH_TO_START_URL')
    GITHUB_WEBHOOK_TOKEN = ENV.fetch('GITHUB_WEBHOOK_TOKEN')
    DEPLOY_KEY_NAME = 'LintCI'

    class << self
      def service
        new(SERVICE_TOKEN)
      end
    end

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
      @service_client = Octokit::Client.new(access_token: SERVICE_TOKEN, auto_paginate: true)
    end

    def team_api
      TeamAPI.new(client, service_client)
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

      add_deploy_key(repository)
      add_webhook(repository)
    end

    def remove_lintci_from_repository(repository)
      remove_webhook(repository)
      remove_deploy_key(repository)

      if repository.organization?
        team_api.remove_membership(repository, SERVICE_USERNAME)
      else
        client.remove_collaborator(repository.full_name, SERVICE_USERNAME)
      end
    end

  protected

    attr_reader :client, :service_client

  private

    def add_deploy_key(repository)
      # TODO: Store deploy key ID for removing later
      client.add_deploy_key(repository.full_name, DEPLOY_KEY_NAME, repository.public_key)
    end

    def remove_deploy_key(repository)
      deploy_key = client.deploy_keys(repository.full_name).find{|key| key.name == DEPLOY_KEY_NAME}

      client.remove_deploy_key(repository.full_name, deploy_key.id)
    end

    def add_webhook(repository)
      # TODO: Store webhook ID for removing later
      client.create_hook(
        repository.full_name,
        'web',
        {
          url: PUSH_TO_START_URL,
          secret: GITHUB_WEBHOOK_TOKEN,
          content_type: 'application/x-www-form-urlencoded'
        },
        active: true,
        events: ['push', 'pull_request']
      )
    end

    def remove_webook(repository)
    end
  end
end
