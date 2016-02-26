require 'spec_helper'

describe API::V1::UserSerializer do
  describe '#as_json' do
    let(:object){build(:user)}
    subject(:serializer){ActiveModel::SerializableResource.new(object, serializer: described_class)}


    it 'generates the expected json' do
      expect(serializer.as_json).to be_json_api_resource('user').
                                    with_relationships('repositories', 'access_token').
                                    with_attributes(
                                      email: 'bob@gmail.com',
                                      provider: 'github',
                                      username: 'bob'
                                    )
    end
  end
end
