require 'spec_helper'

describe TaskSerializer do
  describe '#to_json' do
    let(:task){build(:classify_task)}
    subject(:serializer){described_class.new(task)}

    let(:expected_json) do
      <<-JSON.chomp
{
  "task": {
    "id": null,
    "type": "ClassifyTask",
    "status": "queued",
    "language": "All",
    "tool": "Linguist",
    "build": {
      "id": null,
      "event_id": "bdb6ec00-5284-11e4-8e22-6dacd62599e2",
      "pull_request": {
        "id": 1,
        "base_sha": "bbf813a806dacf043a592f04a0ed320236caca3a",
        "head_sha": "6dbc62fe88432b6f9489a3d9f00dddf955a44c4e",
        "branch": "mostly-bad",
        "clone_url": "git://github.com/lintci/guinea_pig.git",
        "owner": "lintci",
        "repo": "guinea_pig"
      }
    }
  }
}
JSON
    end

    it 'generates the expected json' do
      expect(pretty serializer.to_json).to eq(expected_json)
    end

    def pretty(json)
      JSON.pretty_generate(JSON.parse(json))
    end
  end
end
