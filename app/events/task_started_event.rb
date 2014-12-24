class TaskStartedEvent
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat, backtrace: true

  def perform(data)
    StartTask.new(data).call
  end
end
