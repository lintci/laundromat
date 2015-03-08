FactoryGirl.define do
  factory :event, class: String do
    skip_create
    initialize_with{'pull_request'}
  end

  factory :event_id, class: String do
    skip_create
    initialize_with{'bdb6ec00-5284-11e4-8e22-6dacd62599e2'}
  end

  factory :payload_received, aliases: [:pull_request_opened_payload_received], class: Hash do
    event
    event_id
    payload{build(:payload_data)}

    skip_create
    initialize_with do
      {
        'meta' => {
          'event' => event,
          'event_id' => event_id
        },
        'payload' => payload
      }
    end
  end
end
