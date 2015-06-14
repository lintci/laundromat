FactoryGirl.define do
  factory :repository do
    association :owner, strategy: :build

    owner_name 'lintci'
    name 'guinea_pig'
    provider Provider[:github]
  end
end
