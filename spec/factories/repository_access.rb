FactoryGirl.define do
  factory :repository_access, aliases: [:read_repository_access] do
    association :user, strategy: :build
    association :repository, strategy: :build

    access RepositoryAccess::Access::READ

    factory :write_repository_access do
      access RepositoryAccess::Access::WRITE
    end

    factory :admin_repository_access do
      access RepositoryAccess::Access::ADMIN
    end
  end
end
