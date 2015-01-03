class AnalysisTaskCompletedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat, backtrace: true

  def perform(data)
    CompleteAnalysisTask.call(data)
  end
end
