# Notified laundromat that an analysis task has been completed
class RepositoryActivationUpdatedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(user_id, repository_id)
    UpdateRepositoryActivation.call(user_id, repository_id)
  end
end
