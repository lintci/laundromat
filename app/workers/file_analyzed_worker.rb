class FileAnalyzedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :dryer, backtrace: true

  def perform(data)
    CritiqueFile.new(data).call
  end
end
