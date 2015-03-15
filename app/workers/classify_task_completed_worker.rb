class ClassifyTaskCompletedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(data)
    CompleteClassifyTask.call(data)
  end
end
