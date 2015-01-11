FactoryGirl.define do
  factory :classify_task do
    association :build, strategy: :build

    language 'All'
    tool 'Linguist'
    status 'queued'

    trait :queued do
      status 'queued'
    end

    trait :running do
      status 'running'
    end
  end
end
