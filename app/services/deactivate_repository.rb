class DeactivateRepository < CommandService
  def initialize(user_id, repository_id)
    @user_id = user_id
    @repository_id = repository_id
  end

  def perform
    remove_lintci_from_repository
  end

protected

  attr_reader :user_id, :repository_id

private

  def remove_lintci_from_repository
    api.remove_lintci_from_repository(repository)
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

  def service_api
    user.provider.service_api
  end
end


class UpdateRepositoryActivation < CommandService
  def initialize(current_user, repository)
    @current_user = current_user
    @repository = repository
  end

  def perform
    if activated?
      add_user_for_commenting
      add_deploy_key
    elsif deactivated?
      remove_user_for_commenting
      remove_deploy_key
    end
  end

protected

  attr_reader :current_user, :repository

private

  def activated?
    repository.previous_changes[:status] == ['deactivated', 'activated']
  end

  def add_user_for_commenting
    api.add_lintci_to_repository(repository)
  end

  def add_deploy_key
    service_api.add_deploy_key(repository)
  end

  def deactivated?
    repository.previous_changes[:status] == ['activated', 'deactivated']
  end

  def remove_user_for_commenting
    api.remove_user_to_repository(repository)
  end

  def api
    current_user.api
  end

  def service_api
    current_user.provider.service_api
  end
end
