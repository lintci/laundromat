FactoryGirl.define do
  factory :repository do
    association :owner, strategy: :build

    owner_name 'lintci'
    name 'guinea_pig'
    provider Provider[:github]

    factory :owner_repository do
      association :owner, factory: :lexci_lint_org_test_owner, strategy: :build

      owner_name 'lexci-lint-org-test'
      name 'owner'

      factory :owner2_repository do
        name 'owner2'
      end
    end

    factory :personal_repository do
      association :owner, factory: :lexci_lint_owner, strategy: :build

      owner_name 'lexci-lint'
      name 'turbo-adventure'
    end

    factory :read_repository do
      association :owner, factory: :lintci_test_owner, strategy: :build

      owner_name 'lintci-test'
      name 'read'

      factory :write_repository do
        name 'write'
      end

      factory :admin_repository do
        name 'admin'
      end
    end
  end
end
