module Github
  class API
    SERVICE_USERNAME = ENV.fetch('GITHUB_SERVICE_USER')
    SERVICE_TOKEN = ENV.fetch('GITHUB_SERVICE_TOKEN')
    CLIENT_ID = ENV.fetch('GITHUB_CLIENT_ID')
    CLIENT_SECRET = ENV.fetch('GITHUB_CLIENT_SECRET')
    PUSH_TO_START_URL = ENV.fetch('PUSH_TO_START_URL')
    GITHUB_WEBHOOK_TOKEN = ENV.fetch('GITHUB_WEBHOOK_TOKEN')
    DEPLOY_KEY_NAME = 'LintCI'

    attr_accessor :client, :service_client

    class << self
      def service
        new(SERVICE_TOKEN)
      end
    end

    def initialize(access_token = nil)
      @client = if access_token
        Github::Client.new(access_token: access_token, auto_paginate: true)
      else
        Github::Client.new(
          client_id: CLIENT_ID,
          client_secret: CLIENT_SECRET,
          auto_paginate: true
        )
      end
      @service_client = Github::Client.new(access_token: SERVICE_TOKEN, auto_paginate: true)
    end

    def team_api
      TeamAPI.new(client, service_client)
    end

    def access_token(authorization_code)
      client.exchange_code_for_token(authorization_code)
    end

    def user
      user = client.user
      user = user.with_email_from_api(client.emails) if user.email.blank?

      user
    end

    def repositories
      return to_enum(:repositories) unless block_given?

      client.repositories.each do |repository|
        yield repository
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

    def add_lintci_to_repository(repository, activation)
      if repository.private?
        client.add_collaborator(repository.full_name, SERVICE_USERNAME)
      end

      activation.deploy_key_id = add_deploy_key(repository, activation)
      activation.webhook_id = add_webhook(repository)
    end

    def remove_lintci_from_repository(repository, activation)
      remove_webhook(repository, activation)
      remove_deploy_key(repository, activation)

      if repository.private?
        client.remove_collaborator(repository.full_name, SERVICE_USERNAME)
      end
    end

  private

    def add_deploy_key(repository, activation)
      deploy_key = client.add_deploy_key(repository.full_name, DEPLOY_KEY_NAME, activation.public_key)

      deploy_key.id
    end

    def remove_deploy_key(repository, activation)
      client.remove_deploy_key(repository.full_name, activation.deploy_key_id)
    end

    def add_webhook(repository)
      webhook = client.create_hook(
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

      webhook.id
    end

    def remove_webhook(repository, activation)
      client.remove_hook(repository.full_name, activation.webhook_id)
    end
  end
end
