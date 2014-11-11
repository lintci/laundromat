# Event enqueued when a payload is received
class PayloadReceivedEvent
  include Sidekiq::Worker

  sidekiq_options queue: :laundry, backtrace: true

  def perform(event, payload_data)
    BuildRequest.new(event, payload_data).request
  end
end
