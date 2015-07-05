FactoryGirl.define do
  factory :github_repository, class: Github::Repository do
    uid 12980159
    username 'lexci-lint'
    email 'bob@gmail.com'

    skip_create
    initialize_with do
      new(
        build(
          :sawyer_resource,
          data: {
            'login' =>  username,
            'id' =>  uid,
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
            'site_admin' => false,
            'name' => '',
            'company' => '',
            'blog' => '',
            'location' => '',
            'email' =>  email,
            'hireable' => false,
            'bio' => nil,
            'public_repos' => 1,
            'public_gists' => 0,
            'followers' => 0,
            'following' => 0,
            'created_at' => '2015-06-20T16:57:16Z',
            'updated_at' => '2015-06-20T17:41:27Z',
            'private_gists' => 0,
            'total_private_repos' => 0,
            'owned_private_repos' => 0,
            'disk_usage' => 0,
            'collaborators' => 0,
            'plan' => {
              'name' => 'free',
              'space' => 976562499,
              'collaborators' => 0,
              'private_repos' => 0
            }
          }
        )
      )
    end
  end
end
