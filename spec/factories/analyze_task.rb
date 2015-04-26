FactoryGirl.define do
  factory :analyze_task do
    association :build, strategy: :build

    language 'All'
    tool 'Linguist'
    status 'queued'

    trait :queued do
      status 'queued'
    end

    trait :running do
      status 'running'
      started_at{Time.stamp_time - 3.minutes}
    end
  end
end
