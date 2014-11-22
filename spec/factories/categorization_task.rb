FactoryGirl.define do
  factory :categorization_task do
    language 'All'
    linter 'None'
    status 'queued'

    factory :queued_categorization_task do
    end

    factory :running_categorization_task do
      status 'running'
    end
  end
end
