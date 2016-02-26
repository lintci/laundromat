require 'spec_helper'

describe API::V1::AccessTokenSerializer do
  describe '#as_json' do
    let(:object){build(:access_token)}
    subject(:serializer){ActiveModel::SerializableResource.new(object, serializer: described_class)}


    it 'generates the expected json' do
      expect(serializer.as_json).to be_json_api_resource('access_token').
                                    with_relationships('user').
                                    with_attributes(
                                      access_token: be_a(String),
                                      expires_in: be_a(Integer)
                                    )
    end
  end
end
