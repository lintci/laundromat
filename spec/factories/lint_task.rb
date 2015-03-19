FactoryGirl.define do
  factory :lint_task do
    association :build, strategy: :build

    language 'Ruby'
    tool 'RuboCop'
    status 'queued'

    trait :with_modified_files do
      after(:build) do |task, _|
        task.modified_files = [build(:modified_file, lint_task: task)]
      end
    end

    trait :queued do
      status 'queued'
    end

    trait :running do
      status 'running'
    end
  end
end
