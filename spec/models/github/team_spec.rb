require 'spec_helper'

describe Github::Team do
  describe '.from_api' do
    let(:api_team){build(:sawyer_resource, data: data)}
    subject(:provider_team){described_class.from_api(api_team)}

    it 'correctly constructs the provider team', :aggregate_failures do
      expect(subject.id).to eq('1580679')
      expect(subject.name).to eq('Testing Read Access')
      expect(subject.access).to eq(RepositoryAccess::READ)
      expect(subject.privacy).to eq('secret')
    end

    let(:data) do
      {
        'name' => 'Testing Read Access',
        'id' => 1580679,
        'slug' => 'testing-read-access',
        'description' => '',
        'permission' => 'pull',
        'url' => 'https://api.github.com/teams/1580679',
        'members_url' => 'https://api.github.com/teams/1580679/members{/member}',
        'repositories_url' => 'https://api.github.com/teams/1580679/repos',
        'privacy' => 'secret',
        'members_count' => 1,
        'repos_count' => 1,
        'organization' => {
          'login' => 'lintci',
          'id' => 7980645,
          'url' => 'https://api.github.com/orgs/lintci',
          'repos_url' => 'https://api.github.com/orgs/lintci/repos',
          'events_url' => 'https://api.github.com/orgs/lintci/events',
          'members_url' => 'https://api.github.com/orgs/lintci/members{/member}',
          'public_members_url' => 'https://api.github.com/orgs/lintci/public_members{/member}',
          'avatar_url' => 'https://avatars.githubusercontent.com/u/7980645?v=3',
          'description' => '',
          'name' => 'LintCI',
          'company' => nil,
          'blog' => 'www.lintci.com',
          'location' => '',
          'email' => '',
          'public_repos' => 11,
          'public_gists' => 0,
          'followers' => 0,
          'following' => 0,
          'html_url' => 'https://github.com/lintci',
          'created_at' => '2014-06-25T00:23:37Z',
          'updated_at' => '2015-08-24T18:43:15Z',
          'type' => 'Organization'
        }
      }
    end
  end
end
