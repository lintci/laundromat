require 'rails_helper'

RSpec.describe RepositoryAccess, type: :model do
  describe '#initialize' do
    subject(:repo_access){described_class.new}

    it 'assigns a default access of read' do
      expect(repo_access.access).to eq(described_class::READ)
    end
  end

  describe '#valid?' do
    subject(:repo_access){build(:repository_access)}

    it 'requires a user' do
      repo_access.user = nil

      expect(repo_access).to_not be_valid
    end

    it 'requires a repository' do
      repo_access.repository = nil

      expect(repo_access).to_not be_valid
    end

    it 'requires a access' do
      repo_access.access = nil

      expect(repo_access).to_not be_valid
    end

    it 'requires a valid access level' do
      repo_access.access = 'something invalid'

      expect(repo_access).to_not be_valid
    end
  end

  context 'when access is admin' do
    subject{build(:admin_repository_access)}

    describe '#admin?' do
      it{is_expected.to be_admin}
    end

    describe '#write?' do
      it{is_expected.to_not be_write}
    end

    describe '#read?' do
      it{is_expected.to_not be_read}
    end
  end

  context 'when access is write' do
    subject{build(:write_repository_access)}

    describe '#admin?' do
      it{is_expected.to_not be_admin}
    end

    describe '#write?' do
      it{is_expected.to be_write}
    end

    describe '#read?' do
      it{is_expected.to_not be_read}
    end
  end

  context 'when access is read' do
    subject{build(:read_repository_access)}

    describe '#admin?' do
      it{is_expected.to_not be_admin}
    end

    describe '#write?' do
      it{is_expected.to_not be_write}
    end

    describe '#read?' do
      it{is_expected.to be_read}
    end
  end
end
