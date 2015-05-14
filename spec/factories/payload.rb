FactoryGirl.define do
  factory :payload, aliases: [:pull_request_opened_payload] do
    data{build(:payload_data)}

    skip_create
    initialize_with{Payload.new(data)}

    factory :pull_request_reopened_payload do
      data{build(:pull_request_opened_payload_data)}
    end
  end

  factory :payload_data, aliases: [:pull_request_opened_payload_data], class: Hash do
    fixture 'pull_request_opened_payload'

    skip_create
    initialize_with do
      path = File.expand_path('../../fixtures/github', __FILE__)
      json = File.read(File.join(path, "#{fixture}.json"))
      JSON.parse(json)
    end

    factory :pull_request_reopened_payload_data do
      fixture 'pull_request_reopened_payload'
    end
  end
end
