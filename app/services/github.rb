class Github
  def initialize(access_token = nil)
    @client = if access_token
      Octokit::Client.new(access_token: access_token)
    else
      Octokit::Client.new(
        client_id: ENV.fetch('GITHUB_CLIENT_ID'),
        client_secret: ENV.fetch('GITHUB_CLIENT_SECRET')
      )
    end
  end

  delegate :exchange_code_for_token, to: :client

  def user
    user = client.user
    user.email = user.emails.find(&:primary).email if user.email.blank?
    user
  end

protected

  attr_reader :client
end
