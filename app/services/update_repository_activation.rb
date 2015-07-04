class UpdateRepositoryActivation < CommandService
  def initialize(user, repository_id, params)
    @repository = user.repositories.find(repository_id)
    @params = params
  end

  def perform
    update_record
    add_user_for_commenting
    add_deploy_key
  end

protected

  attr_reader :repository, :params

private

end
