require 'spec_helper'

describe Payload::PullRequest do
  subject(:pull_request){build(:pull_request)}

  its(:id){is_expected.to eq(1)}
  its(:base_sha){is_expected.to eq('bbf813a806dacf043a592f04a0ed320236caca3a')}
  its(:head_sha){is_expected.to eq('6dbc62fe88432b6f9489a3d9f00dddf955a44c4e')}
  its(:branch){is_expected.to eq('mostly-bad')}
  its(:clone_url){is_expected.to eq('git://github.com/lintci/guinea_pig.git')}
  its(:owner){is_expected.to eq('lintci')}
  its(:repo){is_expected.to eq('guinea_pig')}
  its(:slug){is_expected.to eq('lintci/guinea_pig/mostly-bad')}
  its(:inspect){is_expected.to eq('<PullRequest:lintci/guinea_pig/mostly-bad (bbf813a...6dbc62f)>')}

  describe '#comment' do
    let(:violations){['This is wrong']}

    it 'delegates commenting to PullRequest::Comment' do
      expect_any_instance_of(Payload::PullRequest::Comment).to receive(:add).with('bad.rb', '1', violations)

      pull_request.comment('bad.rb', '1', violations)
    end
  end
end
