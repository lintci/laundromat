require 'spec_helper'

describe SourceFileSerializer do
  let(:source_file){build(:source_file)}
  subject(:serializer){described_class.new(source_file)}

  describe '#as_json' do
    it 'generates the expected json' do
      expect(serializer.as_json).to eq(
        source_file: {
          id: nil,
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
        }
      )
    end
  end
end
