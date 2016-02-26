require 'spec_helper'

describe Msg::V1::AnalyzeTaskSerializer do
  describe '#as_json' do
    let(:object){FactoryGirl.build(:analyze_task)}
    subject(:serializer){ActiveModel::SerializableResource.new(object, serializer: described_class)}


    it 'generates the expected json' do
      expect(serializer.as_json).to be_json_api_resource('analyze_task').
                                    with_relationships('build').
                                    with_attributes(
                                      status: 'queued',
                                      language: 'All',
                                      tool: 'Linguist',
                                    )
    end
  end
end
