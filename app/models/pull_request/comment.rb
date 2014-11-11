class PullRequest
  # Creates comments on pull requests
  class Comment
    def initialize(pull_request)
      @pull_request = pull_request
    end

    def add(file, line, violations)
      client.create_pull_request_comment(
        repo,
        pull_request.id,
        format(violations),
        pull_request.head_sha,
        file,
        line
      )
    end

  protected

    attr_reader :pull_request

  private

    def format(violations)
      violations.messages.join('<br>')
    end

    def repo
      "#{pull_request.owner}/#{pull_request.repo}"
    end

    def client
      @client ||= Octokit::Client.new(
        login: ENV['GITHUB_USER'],
        password: ENV['GITHUB_PASSWORD']
      )
    end
  end
end
