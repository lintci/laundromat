FactoryGirl.define do
  factory :github_user, class: Github::User do
    uid 12980159
    username 'lexci-lint'
    email 'lexci@lintci.com'

    skip_create
    initialize_with do
      new(
        uid: uid,
        username: username,
        email: email
      )
    end
  end
end
