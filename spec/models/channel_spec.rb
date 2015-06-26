require 'spec_helper'

describe Channel do
  describe '#[]' do
    subject(:channel){described_class[channel_name]}

    context 'when given a user channel name' do
      let(:channel_name){'private-user:1'}

      it 'generates a user channel with id: 1', :aggregate_failures do
        expect(channel).to be_a(Channel::User)
        expect(channel.name).to eq(channel_name)
        expect(channel.id).to eq(1)
      end
    end

    context 'when given a repository channel name' do
      let(:channel_name){'private-repository:1'}

      it 'generates a repository channel with id: 1', :aggregate_failures do
        expect(channel).to be_a(Channel::Repository)
        expect(channel.name).to eq(channel_name)
        expect(channel.id).to eq(1)
      end
    end

    context 'when given a nonsense channel name' do
      let(:channel_name){'private-robot:1'}

      it 'returns nil' do
        expect(channel).to eq(nil)
      end
    end
  end
end
