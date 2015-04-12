FactoryGirl.define do
  factory :lint_task do
    association :build, strategy: :build

    language 'Ruby'
    tool 'RuboCop'
    status 'queued'

    trait :with_source_files do
      source_files{build_list(:source_file, 1, build: build)}
    end

    trait :queued do
      status 'queued'
    end

    trait :running do
      status 'running'
    end
  end
end
