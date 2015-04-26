require 'spec_helper'

describe SourceFileGroup do
  subject(:group){build(:source_file_group)}

  its(:tool){is_expected.to eq('RuboCop')}
  its(:language){is_expected.to eq('Ruby')}

  describe '#<<' do
    let(:source_file){build(:source_file)}

    it 'adds a source file' do
      expect{group << source_file}.to change{group.size}.by(1)
    end
  end
end
