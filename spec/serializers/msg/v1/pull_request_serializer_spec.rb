require 'spec_helper'

describe Msg::V1::PullRequestSerializer do
  describe '#as_json' do
    let(:object){FactoryGirl.build(:pull_request)}
    subject(:serializer){ActiveModel::SerializableResource.new(object, serializer: described_class)}


    it 'generates the expected json' do
      expect(serializer.as_json).to be_json_api_resource('pull_request').
                                    with_attributes(
                                      base_sha: 'bbf813a806dacf043a592f04a0ed320236caca3a',
                                      head_sha: '6dbc62fe88432b6f9489a3d9f00dddf955a44c4e',
                                      branch: 'mostly-bad',
                                      clone_url: 'git://github.com/lintci/guinea_pig.git',
                                      owner: 'lintci',
                                      repo: 'guinea_pig'
                                    )
    end
  end
end
