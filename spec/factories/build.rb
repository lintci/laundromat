FactoryGirl.define do
  factory :build do
    association :repository, strategy: :build, factory: :personal_repository
    payload

    event 'pull_request'
    event_id 'bdb6ec00-5284-11e4-8e22-6dacd62599e2'
  end
end
