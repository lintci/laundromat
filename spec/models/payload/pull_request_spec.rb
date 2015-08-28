require 'spec_helper'

describe Payload::PullRequest do
  subject(:pull_request){build(:pull_request)}

  it do
    is_expected.to have_attributes(
      id: 1,
      base_sha: 'bbf813a806dacf043a592f04a0ed320236caca3a',
      head_sha: '6dbc62fe88432b6f9489a3d9f00dddf955a44c4e',
      branch: 'mostly-bad',
      clone_url: 'git://github.com/lintci/guinea_pig.git',
      owner: 'lintci',
      repo: 'guinea_pig',
      inspect: '<PullRequest:lintci/guinea_pig (bbf813a...6dbc62f)>',
      repo_full_name: 'lintci/guinea_pig'
    )
  end

  describe '#comment' do
    let(:violations){['This is wrong']}

    it 'delegates commenting to PullRequest::Comment' do
      expect_any_instance_of(Payload::PullRequest::Comment).to receive(:add).with('bad.rb', '1', violations)

      pull_request.comment('bad.rb', '1', violations)
    end
  end

  describe '#==' do
    context 'when compared to the same pull request' do
      let(:other_pull_request){build(:pull_request)}

      it 'returns true' do
        expect(pull_request).to eq(other_pull_request)
      end
    end

    context 'when compared to a different pull request' do
      let(:other_pull_request){Payload::PullRequest.new({})}

      it 'returns false' do
        expect(pull_request).to_not eq(other_pull_request)
      end
    end
  end
end
