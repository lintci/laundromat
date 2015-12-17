FactoryGirl.define do
  factory :github_team, class: Github::Team do
    id 1656969
    name 'admin'
    access RepositoryAccess::ADMIN
    privacy 'secret'

    skip_create
    initialize_with do
      new(
        id: id,
        name: name,
        access: access,
        privacy: privacy
      )
    end
  end
end
