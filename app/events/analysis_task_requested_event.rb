class AnalysisTaskRequestedEvent
  include Sidekiq::Worker

  sidekiq_options queue: :dryer, backtrace: true

  def perform(data)
  end
end
