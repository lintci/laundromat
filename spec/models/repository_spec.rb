require 'rails_helper'

RSpec.describe Repository, type: :model do
  describe '.for_user' do
    let!(:user){create(:user)}
    let!(:accessible_repo){create(:repository)}
    let!(:inaccessible_repo){create(:repository)}
    let!(:repo_access){create(:repository_access, user: user, repository: accessible_repo)}

    it 'returns all repositories accessible by a user', :aggregate_failures do
      repositories = described_class.for_user(user)

      expect(repositories.size).to eq(1)
      expect(repositories.first).to eq(accessible_repo)
    end
  end

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
  end

  describe '#create_build!' do
    let(:event){'pull_request'}
    let(:event_id){'bdb6ec00-5284-11e4-8e22-6dacd62599e2'}
    let(:payload){build(:payload)}
    subject(:repository){create(:repository)}

    it 'creates a build with the passed event and payload', :aggregate_failures do
      build = repository.create_build!(event, event_id, payload)

      expect(build).to be_a(Build)
      expect(build.event).to eq(event)
      expect(build.event_id).to eq(event_id)
      expect(build.payload).to eq(payload)
    end
  end
end
