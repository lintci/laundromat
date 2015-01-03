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

  describe '#create_build!' do
    let(:event){'pull_request'}
    let(:payload){build(:payload)}
    subject(:repository){create(:repository)}

    it 'creates a build with the passed event and payload' do
      build = repository.create_build!(event, payload)

      expect(build).to be_a(Build)
      expect(build.event).to eq(event)
      expect(build.payload).to eq(payload)
    end
  end
end
