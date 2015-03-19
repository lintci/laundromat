require 'spec_helper'

describe Classification::Group do
  subject(:group){build(:group)}

  its(:linter){is_expected.to eq('RuboCop')}
  its(:language){is_expected.to eq('Ruby')}

  describe '#each_file_modification' do
    it 'yields the modified files' do
      group.each_modified_file do |file|
        expect(file).to be_a(Classification::ModifiedFile)
      end
    end
  end

  describe '#skip?' do
    context 'with a known linter' do
      it{is_expected.to_not be_skip}
    end

    context 'with an unknown linter' do
      subject(:group){build(:group, linter: 'Unknown')}

      it{is_expected.to be_skip}
    end
  end
end
