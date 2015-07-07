class SyncRepositories < CommandService
  def initialize(provider, user_id)
    @provider = Provider[provider]
    @user = User.includes(:active_access_token).find(user_id)
  end

  def call
    api.repositories do |provider_repository|
      repository = upsert_repository!(provider_repository)
      upsert_repository_access!(repository, provider_repository) # TODO: Also delete
    end
  end

protected

  attr_reader :provider, :user

private

  def upsert_repository!(provider_repository)
    Repository.upsert_from_provider!(provider_repository)
  end

  def upsert_repository_access!(repository, provider_repository)
    user.upsert_repository_access!(repository, provider_repository.access)
  end

  def api
    provider.api(user.active_access_token.provider_token)
  end
end
