require 'spec_helper'

describe SourceFileGroup do
  subject(:group){build(:source_file_group)}

  it do
    is_expected.to have_attributes(
      tool: 'RuboCop',
      language: 'Ruby'
    )
  end

  describe '#<<' do
    let(:source_file){build(:source_file)}

    it 'adds a source file' do
      expect{group << source_file}.to change{group.size}.by(1)
    end
  end

  describe '#==' do
    context 'when compared to identical group' do
      let(:other_group){build(:source_file_group, source_files: group.source_files)}

      it 'returns true' do
        expect(group).to eq(other_group)
      end
    end

    context 'when compared to a different group' do
      let(:other_group){build(:source_file_group, language: 'Go')}

      it 'returns false' do
        expect(group).to_not eq(other_group)
      end
    end
  end
end
