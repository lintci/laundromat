require 'spec_helper'

describe Classification::Linter do
  subject(:linter){build(:linter)}

  its(:name){is_expected.to eq('Rubocop')}
  its(:language){is_expected.to eq('Ruby')}

  describe '#each_file_modification' do
    it 'yields the modified files' do
      linter.each_modified_file do |file|
        expect(file).to be_a(Classification::ModifiedFile)
      end
    end
  end
end