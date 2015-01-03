class TaskStartedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat, backtrace: true

  def perform(data)
    StartTask.call(data)
  end
end
