class ClassifyTaskCompletedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat, backtrace: true

  def perform(data)
    CompleteClassifyTask.call(data)
  end
end
