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
    let(:event_id){'bdb6ec00-5284-11e4-8e22-6dacd62599e2'}
    let(:payload){build(:payload)}
    subject(:repository){create(:repository)}

    it 'creates a build with the passed event and payload' do
      build = repository.create_build!(event, event_id, payload)

      expect(build).to be_a(Build)
      expect(build.event).to eq(event)
      expect(build.event_id).to eq(event_id)
      expect(build.payload).to eq(payload)
    end
  end
end
