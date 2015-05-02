# Message from dryer that file has been linted.
class FileLintedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(data)
    CritiqueFile.call(data)
  end
end
