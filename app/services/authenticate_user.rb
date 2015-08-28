class AuthenticateUser < CommandService
  callback :success, :failure

  def initialize(provider, authorization_code)
    @provider = Provider.fetch(provider)
    @authorization_code = authorization_code
  end

  def call
    user, access_token = authorize_with_code

    if user.persisted?
      enqueue_repositories_sync(user)
      success(access_token)
    else
      failure(user.errors)
    end
  end

protected

  attr_reader :provider, :authorization_code

private

  def authorize_with_code
    provider_access_token = provider.api.access_token(authorization_code)
    provider_user = provider.api(provider_access_token.access_token).user

    user = User.upsert_from_provider!(provider_user)
    access_token = user.upsert_access_token_from_provider!(provider_access_token)

    [user, access_token]
  end

  def enqueue_repositories_sync(user)
    SyncRepositoriesWorker.perform_async(user.id)
  end
end
