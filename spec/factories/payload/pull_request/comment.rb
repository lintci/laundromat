FactoryGirl.define do
  factory :pull_request_comment, class: Payload::PullRequest::Comment do
    pull_request{build(:pull_request)}

    skip_create
    initialize_with do
      Payload::PullRequest::Comment.new(pull_request)
    end
  end
end
