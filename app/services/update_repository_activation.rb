class UpdateRepositoryActivation < CommandService
  def initialize(user_id, repository_id)
    @user_id = user_id
    @repository_id = repository_id
  end

  def call
    if repository.activating?
      add_lintci_to_repository
      activated
      notify_status
    elsif repository.deactivating?
      remove_lintci_from_repository
      deactivated
      notify_status
    end
  end

protected

  attr_reader :user_id, :repository_id

private

  def add_lintci_to_repository
    api.add_lintci_to_repository(repository, repository.build_activation)
  end

  def remove_lintci_from_repository
    api.remove_lintci_from_repository(repository, repository.activation)
  end

  def activated
    repository.activated!
  end

  def deactivated
    repository.activation.destroy!
    repository.deactivated!
  end

  def notify_status
    channel = Channel::Repository.new(repository.id)
    data = API::V1::RepositoryResource.new(repository).as_json(include: ['owner'])

    Pusher.trigger(channel.name, 'data-updated', data)
  end

  def repository
    @repository ||= user.repositories.find(repository_id)
  end

  def user
    @user ||= User.find(user_id)
  end

  def api
    user.api
  end
end
