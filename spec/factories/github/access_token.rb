FactoryGirl.define do
  factory :github_access_token, class: Github::AccessToken do
    access_token '28cc8832046954d4343de2afff2c50edf0f67b38'
    scope 'repo,user'

    skip_create
    initialize_with do
      new(
        access_token: access_token,
        scope: scope
      )
    end
  end
end
