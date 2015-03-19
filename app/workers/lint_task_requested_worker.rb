class LintTaskRequestedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :dryer

  def perform(data)
  end
end
