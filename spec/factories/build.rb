FactoryGirl.define do
  factory :build do
    association :repository, strategy: :build
    payload

    event 'pull_request'
  end
end
