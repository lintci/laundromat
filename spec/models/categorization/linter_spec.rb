require 'spec_helper'

describe Categorization::Linter do
  subject(:linter){build(:linter)}

  its(:name){is_expected.to eq('Rubocop')}
  its(:language){is_expected.to eq('Ruby')}

  describe '#each_file_modification' do
    it 'yields the modified files' do
      linter.each_file_modification do |file|
        expect(file).to be_a(Categorization::ModifiedFile)
      end
    end
  end
end
