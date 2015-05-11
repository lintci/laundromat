# Notified laundromat that a lint task has been completed
class LintTaskCompletedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(data)
    ProcessLinting.call(data)
  end
end
