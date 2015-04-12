require 'spec_helper'

describe ClassifyTaskSerializer do
  describe '#as_json' do
    let(:task){build(:classify_task)}
    subject(:serializer){described_class.new(task)}

    it 'generates the expected json' do
      expect(serializer.as_json).to eq(classify_task: {
                                         id: nil,
                                         type: 'ClassifyTask',
                                         status: 'queued',
                                         language: 'All',
                                         tool: 'Linguist',
                                         build: {
                                           id: nil,
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
                                       })
    end
  end
end
