FactoryGirl.define do
  factory :modified_file do
    association :lint_task, strategy: :build

    name 'ruby.rb'
    lines [2, 3, 7]
  end
end
