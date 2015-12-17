require 'spec_helper'

describe Channel do
  describe '#[]' do
    subject(:channel){described_class[channel_name]}

    context 'when given a user channel name' do
      let(:channel_name){'private-user@5728122A-9B38-4B4E-AE2D-966E5797BB19'}

      it 'generates a user channel with id: 1', :aggregate_failures do
        expect(channel).to be_a(Channel::User)
        expect(channel.name).to eq(channel_name)
        expect(channel.id).to eq('5728122A-9B38-4B4E-AE2D-966E5797BB19')
      end
    end

    context 'when given a repository channel name' do
      let(:channel_name){'private-repository@5728122A-9B38-4B4E-AE2D-966E5797BB19'}

      it 'generates a repository channel with id: 1', :aggregate_failures do
        expect(channel).to be_a(Channel::Repository)
        expect(channel.name).to eq(channel_name)
        expect(channel.id).to eq('5728122A-9B38-4B4E-AE2D-966E5797BB19')
      end
    end

    context 'when given a nonsense channel name' do
      let(:channel_name){'private-robot@1'}

      it 'returns nil' do
        expect(channel).to eq(nil)
      end
    end
  end
end
