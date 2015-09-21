require 'spec_helper'

describe BuildSerializer do
  let(:build){FactoryGirl.build(:build)}
  subject(:serializer){described_class.new(build)}

  describe '#as_json' do
    it 'generates the expected json' do
      expect(serializer.as_json).to match(
        build: {
          id: nil,
          ssh_public_key: match(/ssh-rsa/),
          ssh_private_key: match(/-----BEGIN RSA PRIVATE KEY-----/),
          pull_request: {
            id: 1,
            base_sha: 'bbf813a806dacf043a592f04a0ed320236caca3a',
            head_sha: '6dbc62fe88432b6f9489a3d9f00dddf955a44c4e',
            branch: 'mostly-bad',
            clone_url: 'git://github.com/lintci/guinea_pig.git',
            owner: 'lintci',
            repo: 'guinea_pig'
          }
        }
      )
    end
  end
end
