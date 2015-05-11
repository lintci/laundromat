# Notifies dryer to perform analyze task
class AnalyzeTaskRequestedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :dryer

  def perform(_data)
  end
end
