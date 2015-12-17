FactoryGirl.define do
  factory :github_repository, class: Github::Repository do
    name 'turbo-adventure'
    owner_name 'lexci-lint'
    access RepositoryAccess::ADMIN

    skip_create
    initialize_with do
      new(
        name: name,
        owner_name: owner_name,
        access: access
      )
    end
  end
end
