# Notified laundromat that an analysis task has been completed
class AnalyzeTaskCompletedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(data)
    ProcessSourceFiles.call(data)
  end
end
