class ActivateRepository < CommandService
  def initialize(user_id, repository_id)
    @user_id = user_id
    @repository_id = repository_id
  end

  def perform
    add_lintci_to_repository
  end

protected

  attr_reader :user_id, :repository_id

private

  def add_lintci_to_repository
    api.add_lintci_to_repository(repository)
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
