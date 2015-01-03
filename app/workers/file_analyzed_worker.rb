class FileAnalyzedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat, backtrace: true

  def perform(data)
    CritiqueFile.new(data).call
  end
end
