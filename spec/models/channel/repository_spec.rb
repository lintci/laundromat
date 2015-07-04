require 'spec_helper'

describe Channel::Repository do
  describe '#authorized?' do
    subject(:channel){described_class.new(repository.id)}

    context 'when current user has access to repository' do
      let(:current_user){create(:user, :with_repository)}
      let(:repository){current_user.repositories.first}

      it 'returns true' do
        expect(channel).to be_authorized(current_user)
      end
    end

    context 'when current user does not have access' do
      let(:repository){Repository.new(id: 1)}
      let(:current_user){create(:user)}

      it 'returns false' do
        expect(channel).to_not be_authorized(current_user)
      end
    end
  end
end
