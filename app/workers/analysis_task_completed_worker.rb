class LintTaskCompletedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat, backtrace: true

  def perform(data)
    CompleteLintTask.call(data)
  end
end
