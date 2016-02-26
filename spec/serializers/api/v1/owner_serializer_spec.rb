require 'spec_helper'

describe API::V1::OwnerSerializer do
  describe '#as_json' do
    let(:object){build(:owner)}
    subject(:serializer){ActiveModel::SerializableResource.new(object, serializer: described_class)}


    it 'generates the expected json' do
      expect(serializer.as_json).to be_json_api_resource('owner').
                                    with_relationships('repositories').
                                    with_attributes(
                                      name: 'lintci',
                                      organization: false,
                                      provider: 'github'
                                    )
    end
  end
end
