FactoryGirl.define do
  factory :owner do
    name 'lintci'
    provider Provider[:github]

    factory :lexci_lint_org_test_owner do
      name 'lexci-lint-org-test'
      organization true
    end

    factory :lexci_lint_owner do
      name 'lexci-lint'
    end

    factory :lintci_test_owner do
      name 'lintci-test'
      organization true
    end
  end
end
