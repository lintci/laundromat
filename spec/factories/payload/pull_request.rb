FactoryGirl.define do
  factory :pull_request, class: Payload::PullRequest do
    payload{build(:pull_request_opened_payload)}

    skip_create
    initialize_with{payload.pull_request}
  end
end
