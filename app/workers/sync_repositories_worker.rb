# Notified laundromat that a lint task has been completed
class SyncRepositoriesWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(user_id)
    SyncRepositories.call(user_id)
  end
end
