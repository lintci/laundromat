# Event enqueued when a payload is received
class PayloadReceivedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat, backtrace: true

  def perform(event, payload_data)
    BuildRequest.call(event, payload_data)
  end
end
