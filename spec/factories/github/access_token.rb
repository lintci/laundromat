FactoryGirl.define do
  factory :github_access_token, class: Github::AccessToken do
    access_token '28cc8832046954d4343de2afff2c50edf0f67b38'
    token_type 'bearer'
    scope 'repo,user'

    skip_create
    initialize_with do
      new(
        build(
          :sawyer_resource,
          data: {
            access_token: access_token,
            token_type: token_type,
            scope: scope
          }
        )
      )
    end
  end
end
