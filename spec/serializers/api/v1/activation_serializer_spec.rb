require 'spec_helper'

describe API::V1::ActivationSerializer do
  describe '#as_json' do
    let(:object){build(:activation)}
    subject(:serializer){ActiveModel::SerializableResource.new(object, serializer: described_class)}


    it 'generates the expected json' do
      expect(serializer.as_json).to be_json_api_resource('activation').
                                    with_relationships('repository')
    end
  end
end
