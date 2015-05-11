FactoryGirl.define do
  factory :analyze_task do
    association :build, strategy: :build

    language 'All'
    tool 'Linguist'
    status 'queued'

    trait :queued do
      status 'queued'
    end

    trait :scheduled do
      status 'scheduled'
      scheduled_at{Time.stamp_time - 4.minutes}
    end

    trait :running do
      status 'running'
      scheduled_at{Time.stamp_time - 4.minutes}
      started_at{Time.stamp_time - 3.minutes}
    end

    trait :success do
      status 'success'
      scheduled_at{Time.stamp_time - 4.minutes}
      started_at{Time.stamp_time - 3.minutes}
      finished_at{Time.stamp_time - 1.minute}
    end

    trait :failed do
      status 'failed'
      scheduled_at{Time.stamp_time - 4.minutes}
      started_at{Time.stamp_time - 3.minutes}
      finished_at{Time.stamp_time - 1.minute}
    end
  end
end
