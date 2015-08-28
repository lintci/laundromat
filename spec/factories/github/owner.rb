FactoryGirl.define do
  factory :github_owner, class: Github::Owner do
    name 'lexci-lint'

    skip_create
    initialize_with do
      new(
        build(
          :sawyer_resource,
          data: {
            'login' => name,
            'id' => 12980159,
            'avatar_url' => 'https://avatars.githubusercontent.com/u/12980159?v=3',
            'gravatar_id' => '',
            'url' => 'https://api.github.com/users/lexci-lint',
            'html_url' => 'https://github.com/lexci-lint',
            'followers_url' => 'https://api.github.com/users/lexci-lint/followers',
            'following_url' => 'https://api.github.com/users/lexci-lint/following{/other_user}',
            'gists_url' => 'https://api.github.com/users/lexci-lint/gists{/gist_id}',
            'starred_url' => 'https://api.github.com/users/lexci-lint/starred{/owner}{/repo}',
            'subscriptions_url' => 'https://api.github.com/users/lexci-lint/subscriptions',
            'organizations_url' => 'https://api.github.com/users/lexci-lint/orgs',
            'repos_url' => 'https://api.github.com/users/lexci-lint/repos',
            'events_url' => 'https://api.github.com/users/lexci-lint/events{/privacy}',
            'received_events_url' => 'https://api.github.com/users/lexci-lint/received_events',
            'type' => 'User',
            'site_admin' => false
          }
        )
      )
    end
  end
end
