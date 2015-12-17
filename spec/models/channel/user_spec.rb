require 'spec_helper'

describe Channel::User do
  describe '#authorized?' do
    subject(:channel){described_class.new(user.id)}
    let(:user){build(:user, id: generate(:uuid))}

    context 'when current user is the owns the channel' do
      let(:current_user){user}

      it 'returns true' do
        expect(channel).to be_authorized(current_user)
      end
    end

    context 'when current user does not own the channel' do
      let(:current_user){build(:user, id: generate(:uuid))}

      it 'returns false' do
        expect(channel).to_not be_authorized(current_user)
      end
    end
  end
end
