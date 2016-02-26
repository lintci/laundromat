require 'spec_helper'

describe Msg::V1::BuildSerializer do
  describe '#as_json' do
    let(:object){FactoryGirl.build(:build)}
    subject(:serializer){ActiveModel::SerializableResource.new(object, serializer: described_class)}


    it 'generates the expected json' do
      expect(serializer.as_json).to be_json_api_resource('build').
                                    with_relationships('pull_request').
                                    with_attributes(
                                      ssh_public_key: match(/ssh-rsa/),
                                      ssh_private_key: match(/-----BEGIN RSA PRIVATE KEY-----/)
                                    )
    end
  end
end
