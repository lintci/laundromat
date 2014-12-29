# Event enqueued when a payload is received
class PayloadReceivedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :laundry, backtrace: true

  def perform(event, payload_data)
    BuildRequest.new(event, payload_data).call
  end
end
