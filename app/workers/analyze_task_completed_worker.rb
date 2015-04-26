class AnalyzeTaskCompletedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(data)
    ProcessSourceFiles.call(data)
  end
end
