# Event enqueued when a payload is received
class PayloadReceivedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat

  def perform(data)
    RequestBuild.call(data)
  end
end
