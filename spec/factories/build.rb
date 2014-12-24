FactoryGirl.define do
  factory :build do
    repository
    payload

    event 'pull_request'
  end
end
