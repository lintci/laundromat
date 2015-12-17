require 'rails_helper'

RSpec.describe Owner, type: :model do
  describe '#valid?' do
    subject(:owner){build(:owner)}

    it 'requires a name' do
      owner.name = nil
      expect(owner).to_not be_valid
    end
  end

  describe '.upsert_from_provider!' do
    context 'when the owner exists' do
      subject!(:owner){create(:owner)}
      let(:provider_repository){build(:github_repository, owner_name: owner.name)}

      it 'returns the existing owner' do
        expect do
          @returned_owner = described_class.upsert_from_provider!(provider_repository)
        end.to_not change{Owner.count}

        expect(owner).to eq(@returned_owner)
      end
    end

    context 'when the owner does not exist' do
      let(:provider_repository){build(:github_repository)}

      it 'returns a new user' do
        expect do
          @owner = described_class.upsert_from_provider!(provider_repository)
        end.to change{Owner.count}.by(1)

        expect(@owner).to have_attributes(
          name: provider_repository.owner_name,
          provider: provider_repository.provider
        )
      end
    end
  end
end
