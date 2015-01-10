require 'rails_helper'

RSpec.describe ModifiedFile, :type => :model do
  describe '#valid?' do
    subject(:modified_file){build(:modified_file)}

    it 'requires a name' do
      modified_file.name = nil

      expect(modified_file).to_not be_valid
    end

    it 'requires lines' do
      modified_file.lines = []

      expect(modified_file).to_not be_valid
    end

    it 'requires an lint task' do
      modified_file.lint_task = nil

      expect(modified_file).to_not be_valid
    end
  end
end
