FactoryGirl.define do
  factory :modified_file do
    association :lint_task, strategy: :build

    name 'ruby.rb'
    lines [1, 2, 3, 4]
  end
end
