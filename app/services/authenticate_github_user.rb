class AuthenticateGithubUser < CommandService
  callback :success, :failure

  def initialize(authorization_code)
    @authorization_code = authorization_code
  end

  def call
    user, access_token = find_or_create_by_authorization_code

    if user.persisted?
      enqueue_repositories_sync(user)
      success(access_token)
    else
      failure(user.errors)
    end
  end

protected

  attr_reader :authorization_code

private

  def find_or_create_by_authorization_code
    token = Github.new.exchange_code_for_token(authorization_code)
    user_data = Github.new(token.access_token).user

    user = User.find_or_create_from_oauth(user_data)
    access_token = user.create_or_update_access_token!(token)

    [user, access_token]
  end

  def enqueue_repositories_sync(user)
    SyncRepositoriesWorker.perform_async(user.id)
  end

  def user_client(token)
    Octokit::Client.new(access_token: token.access_token)
  end
end
