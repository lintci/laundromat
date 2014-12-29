FactoryGirl.define do
  factory :analysis_task, aliases: [:queued_analysis_task] do
    association :build, strategy: :build

    language 'Ruby'
    linter 'Rubocop'
    status 'queued'

    factory :running_analysis_task do
      status 'running'
    end
  end
end
