require 'spec_helper'

describe Msg::V1::SourceFileSerializer do
  describe '#as_json' do
    let(:object){FactoryGirl.build(:source_file)}
    subject(:serializer){ActiveModel::SerializableResource.new(object, serializer: described_class)}


    it 'generates the expected json' do
      expect(serializer.as_json).to be_json_api_resource('source_file').
                                    with_attributes(
                                      name: 'bad.rb',
                                      sha: 'cbc7b6a779837b93563e69511d44cb35051ed712',
                                      source_type: 'Ruby',
                                      language: 'Ruby',
                                      linters: ['RuboCop'],
                                      modified_lines: [1, 2, 3, 4],
                                      extension: '.rb',
                                      size: 31,
                                      generated: false,
                                      vendored: false,
                                      documentation: false,
                                      binary: false,
                                      image: false
                                    )
    end
  end
end
