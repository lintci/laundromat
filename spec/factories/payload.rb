FactoryGirl.define do
  factory :payload, aliases: [:pull_request_opened_payload] do
    data{build(:payload_data)}

    skip_create
    initialize_with{Payload.new(data)}
  end

  factory :payload_data, aliases: [:pull_request_opened_payload_data], class: String do
    fixture 'pull_request_opened_payload'

    skip_create
    initialize_with do
      path = File.expand_path('../../fixtures/github', __FILE__)
      json = File.read(File.join(path, "#{fixture}.json"))
      JSON.parse(json)
    end
  end
end
