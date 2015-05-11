# Notifies dryer to perform a lint task
class LintTaskRequestedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :dryer

  def perform(_data)
  end
end
