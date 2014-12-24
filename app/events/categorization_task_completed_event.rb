class CategorizationTaskCompletedEvent
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat, backtrace: true

  def perform(data)
    CompleteCategorizationTask.new(data).call
  end
end
