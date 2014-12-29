FactoryGirl.define do
  factory :repository do
    association :owner, strategy: :build

    name 'guinea_pig'
    full_name 'lintci/guinea_pig'
  end
end
