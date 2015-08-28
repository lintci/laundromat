class SyncRepositories < CommandService
  def initialize(user_id)
    @user = User.includes(:active_access_token).find(user_id)
    @provider = user.provider
  end

  def call
    api.repositories do |provider_repository|
      repository = upsert_repository!(provider_repository)
      resert_repository_access!(repository, provider_repository) # TODO: Also delete

      notify_channel(repository)
    end
  end

protected

  attr_reader :provider, :user

private

  def upsert_repository!(provider_repository)
    Repository.upsert_from_provider!(provider_repository)
  end

  def resert_repository_access!(repository, provider_repository)
    user.resert_repository_access!(repository, provider_repository.access)
  end

  def notify_channel(repository)
    data = API::V1::RepositoryResource.new(repository).as_json(include: ['owner'])

    Pusher.trigger(channel.name, 'data_updated', data)
  end

  def channel
    Channel::User.new(user.id)
  end

  def api
    provider.api(user.active_access_token.provider_token)
  end
end
