FactoryGirl.define do
  factory :categorization_task, aliases: [:queued_categorization_task] do
    build

    language 'All'
    linter 'None'
    status 'queued'

    factory :running_categorization_task do
      status 'running'
    end
  end
end
