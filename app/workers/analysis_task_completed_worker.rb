class LintTaskCompletedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(data)
    CompleteLintTask.call(data)
  end
end
