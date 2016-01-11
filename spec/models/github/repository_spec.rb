require 'spec_helper'

describe Github::Repository do
  describe '.from_api' do
    let(:api_repository) do
      build(
        :sawyer_resource,
        data: data
      )
    end
    subject(:provider_repository){described_class.from_api(api_repository)}

    it 'correctly constructs the provider repository', :aggregate_failures do
      expect(subject.name).to eq('turbo-adventure')
      expect(subject.access).to eq(RepositoryAccess::ADMIN)
      expect(subject.owner_name).to eq('lexci-lint')
      expect(subject).to_not be_private
    end

    let(:data) do
      {
        'id' => 37778876,
        'name' => 'turbo-adventure',
        'full_name' => 'lexci-lint/turbo-adventure',
        'owner' => {
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
          'site_admin' => false
        },
        'private' => false,
        'html_url' => 'https://github.com/lexci-lint/turbo-adventure',
        'description' => '',
        'fork' => false,
        'url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure',
        'forks_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/forks',
        'keys_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/keys{/key_id}',
        'collaborators_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/collaborators{/collaborator}',
        'teams_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/teams',
        'hooks_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/hooks',
        'issue_events_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/issues/events{/number}',
        'events_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/events',
        'assignees_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/assignees{/user}',
        'branches_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/branches{/branch}',
        'tags_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/tags',
        'blobs_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/git/blobs{/sha}',
        'git_tags_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/git/tags{/sha}',
        'git_refs_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/git/refs{/sha}',
        'trees_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/git/trees{/sha}',
        'statuses_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/statuses/{sha}',
        'languages_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/languages',
        'stargazers_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/stargazers',
        'contributors_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/contributors',
        'subscribers_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/subscribers',
        'subscription_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/subscription',
        'commits_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/commits{/sha}',
        'git_commits_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/git/commits{/sha}',
        'comments_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/comments{/number}',
        'issue_comment_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/issues/comments{/number}',
        'contents_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/contents/{+path}',
        'compare_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/compare/{base}...{head}',
        'merges_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/merges',
        'archive_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/{archive_format}{/ref}',
        'downloads_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/downloads',
        'issues_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/issues{/number}',
        'pulls_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/pulls{/number}',
        'milestones_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/milestones{/number}',
        'notifications_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/notifications{?since,all,participating}',
        'labels_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/labels{/name}',
        'releases_url' => 'https://api.github.com/repos/lexci-lint/turbo-adventure/releases{/id}',
        'created_at' => '2015-06-20T17:31:26Z',
        'updated_at' => '2015-06-20T17:31:26Z',
        'pushed_at' => '2015-06-20T17:31:26Z',
        'git_url' => 'git://github.com/lexci-lint/turbo-adventure.git',
        'ssh_url' => 'git@github.com:lexci-lint/turbo-adventure.git',
        'clone_url' => 'https://github.com/lexci-lint/turbo-adventure.git',
        'svn_url' => 'https://github.com/lexci-lint/turbo-adventure',
        'homepage' => nil,
        'size' => 120,
        'stargazers_count' => 0,
        'watchers_count' => 0,
        'language' => nil,
        'has_issues' => true,
        'has_downloads' => true,
        'has_wiki' => true,
        'has_pages' => false,
        'forks_count' => 0,
        'mirror_url' => nil,
        'open_issues_count' => 0,
        'forks' => 0,
        'open_issues' => 0,
        'watchers' => 0,
        'default_branch' => 'master',
        'master_branch' => 'master',
        'permissions' => {
          'admin' => true,
          'push' => true,
          'pull' => true
        }
      }
    end
  end
end
