FactoryGirl.define do
  factory :github_user, class: Github::User do
    uid 1
    username 'bob'
    email 'bob@gmail.com'

    skip_create
    initialize_with do
      new(
        build(
          :sawyer_resource,
          data: {
            id: uid,
            login: username,
            email: email,
            emails: [{email: email, primary: true}]
          }
        )
      )
    end
  end
end
