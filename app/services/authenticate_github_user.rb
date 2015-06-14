class AuthenticateGithubUser < CommandService
  callback :success, :failure

  def initialize(authorization_code)
    @authorization_code = authorization_code
  end

  def call
    token = exchange_code_for_token
    user_data = lookup_user_data(token)

    user = find_or_create_user(user_data)
    if user.persisted?
      enqueue_repositories_sync(user)
      success(access_token(user, token))
    else
      failure(user.errors)
    end
  end

protected

  attr_reader :authorization_code

private

  def exchange_code_for_token
    app_client.exchange_code_for_token(authorization_code)
  end

  def lookup_user_data(token)
    user_data = user_client(token).user

    user_data.email = user_data.emails.find(&:primary).email if user_data.email.blank?

    user_data
  end

  def find_or_create_user(user_data)
    User.find_or_create_from_oauth(user_data)
  end

  def enqueue_repositories_sync(user)
    SyncRepositoriesWorker.perform_async(user.id)
  end

  def access_token(user, token)
    user.access_tokens.active.first_or_create(provider_token: token.access_token)
  end

  def app_client
    @app_client ||= Octokit::Client.new(
      client_id: ENV['GITHUB_CLIENT_ID'],
      client_secret: ENV['GITHUB_CLIENT_SECRET']
    )
  end

  def user_client(token)
    Octokit::Client.new(access_token: token.access_token)
  end
end
