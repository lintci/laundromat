require 'spec_helper'

describe Msg::V1::LintTaskSerializer do
  describe '#as_json' do
    let(:object){FactoryGirl.build(:lint_task)}
    subject(:serializer){ActiveModel::SerializableResource.new(object, serializer: described_class)}


    it 'generates the expected json' do
      expect(serializer.as_json).to be_json_api_resource('lint_task').
                                    with_relationships('build', 'source_files').
                                    with_attributes(
                                      status: 'queued',
                                      language: 'Ruby',
                                      tool: 'RuboCop'
                                    )
    end
  end
end
