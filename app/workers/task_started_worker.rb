# Notifies laundromat that a task has been started
class TaskStartedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(data)
    StartTask.call(data)
  end
end
