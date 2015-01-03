class CategorizationTaskCompletedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat, backtrace: true

  def perform(data)
    CompleteCategorizationTask.call(data)
  end
end
