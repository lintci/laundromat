require 'rails_helper'

RSpec.describe Owner, type: :model do
  describe '#valid?' do
    subject(:owner){build(:owner)}

    it 'requires a name' do
      owner.name = nil
      expect(owner).to_not be_valid
    end
  end
end
