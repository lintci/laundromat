require 'spec_helper'

describe LintTaskSerializer do
  describe '#as_json' do
    let(:task){build(:lint_task, :with_modified_files)}
    subject(:serializer){described_class.new(task)}

    it 'generates the expected json' do
      expect(serializer.as_json).to eq({
        lint_task: {
          id: nil,
          type: "LintTask",
          status: "queued",
          language: "Ruby",
          tool: "RuboCop",
          build: {
            id: nil,
            pull_request: {
              id: 1,
              base_sha: "bbf813a806dacf043a592f04a0ed320236caca3a",
              head_sha: "6dbc62fe88432b6f9489a3d9f00dddf955a44c4e",
              branch: "mostly-bad",
              clone_url: "git://github.com/lintci/guinea_pig.git",
              owner: "lintci",
              repo: "guinea_pig"
            }
          },
          modified_files: [{
            name: 'ruby.rb',
            lines: [1, 2, 3, 4]
          }]
        }
      })
    end
  end
end
