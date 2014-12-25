require 'rails_helper'

RSpec.describe Repository, :type => :model do
  describe '#valid?' do
    subject(:repository){build(:repository)}

    it 'requires owner to be specified' do
      repository.owner = nil
      expect(repository).to_not be_valid
    end

    it 'requires a name' do
      repository.name = nil
      expect(repository).to_not be_valid
    end

    it 'requires a full_name' do
      repository.full_name = nil
      expect(repository).to_not be_valid
    end
  end
end
