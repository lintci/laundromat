FactoryGirl.define do
  factory :payload do
    data{json_fixture_file('github/pull_request_opened_payload.json')}

    initialize_with{Payload.new(data)}

    factory :pull_request_opened_payload do
    end

    factory :pull_request_reopened_payload do
      data{json_fixture_file('github/pull_request_reopened_payload.json')}
    end
  end
end
