require 'spec_helper'

describe Github::User do
  describe '.from_api' do
    let(:api_user){build(:sawyer_resource, data: user_data)}
    let(:api_emails){build(:sawyer_resources, data: emails_data)}
    subject(:provider_user){described_class.from_api(api_user, api_emails)}

    it 'correctly constructs the provider user', :aggregate_failures do
      expect(subject.uid).to eq('12980159')
      expect(subject.username).to eq('lexci-lint')
      expect(subject.email).to eq('allen+lexci@lintci.com')
    end

    let(:user_data) do
      {
        'login' => 'lexci-lint',
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
        'site_admin' => false,
        'name' => '',
        'company' => '',
        'blog' => '',
        'location' => '',
        'email' => '',
        'hireable' => false,
        'bio' => nil,
        'public_repos' => 1,
        'public_gists' => 0,
        'followers' => 0,
        'following' => 0,
        'created_at' => '2015-06-20T16:57:16Z',
        'updated_at' => '2015-07-04T22:20:47Z'
      }
    end

    let(:emails_data) do
      [{'email' => 'allen+lexci@lintci.com','primary' => true, 'verified' => true}]
    end
  end
end
