FactoryGirl.define do
  factory :lint_task do
    association :build, strategy: :build

    language 'Ruby'
    linter 'Rubocop'
    status 'queued'

    trait :queued do
      status 'queued'
    end

    trait :running do
      status 'running'
    end
  end
end
