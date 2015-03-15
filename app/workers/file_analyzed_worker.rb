class FileAnalyzedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(data)
    CritiqueFile.call(data)
  end
end
