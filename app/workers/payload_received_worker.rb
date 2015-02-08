# Event enqueued when a payload is received
class PayloadReceivedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundromat, backtrace: true

  def perform(event, event_id, payload_data)
    BuildRequest.call(event, event_id, payload_data)
  end
end
