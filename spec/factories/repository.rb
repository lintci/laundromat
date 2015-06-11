FactoryGirl.define do
  factory :repository do
    association :owner, strategy: :build

    owner_name 'lintci'
    name 'guinea_pig'
    host Repository::GITHUB
    slug 'gh/lintci/guinea_pig'
  end
end
