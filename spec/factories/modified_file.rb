FactoryGirl.define do
  factory :modified_file do
    analysis_task

    name 'ruby.rb'
    lines [2, 3, 7]
  end
end
