require 'spec_helper'

describe API::V1::RepositorySerializer do
  describe '#as_json' do
    let(:object){build(:repository)}
    subject(:serializer){ActiveModel::SerializableResource.new(object, serializer: described_class)}


    it 'generates the expected json' do
      expect(serializer.as_json).to be_json_api_resource('repository').
                                    with_relationships('owner').
                                    with_attributes(
                                      name: 'guinea_pig',
                                      owner_name: 'lintci',
                                      provider: 'github',
                                      status: 'inactive'
                                    )
    end
  end
end
