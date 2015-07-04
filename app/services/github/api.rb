module Github
  class API
    def initialize(access_token = nil)
      @client = if access_token
        Octokit::Client.new(access_token: access_token, auto_paginate: true)
      else
        Octokit::Client.new(
          client_id: ENV.fetch('GITHUB_CLIENT_ID'),
          client_secret: ENV.fetch('GITHUB_CLIENT_SECRET'),
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

    def add_user_to_repository(username, repository)
      if repository.organization?

      else
        client.add_collaborator(repository.name, username)
      end
    end

  protected

    attr_reader :client
  end
end
