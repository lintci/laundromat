require 'spec_helper'

describe AuthorizeChannel do
  let(:user){build(:user, id: 1)}
  let(:socket_id){'12345678'}
  subject(:service){described_class.new(user, channel_name, socket_id)}

  describe '#call' do
    context 'when authorized' do
      let(:channel_name){"private-user:#{user.id}"}
      let(:channel){instance_double(Pusher::Channel)}
      let(:authentication){double(:authentication)}

      it 'calls success with the authentication' do
        allow(Pusher).to receive(:channel).with(channel_name).and_return(channel)
        allow(channel).to receive(:authenticate).and_return(authentication)

        service.success do |authentication|
          expect(authentication).to eq(authentication)
        end

        service.failure do
          raise 'it should not fail'
        end

        service.call
      end
    end

    context 'when unauthorized' do
      let(:channel_name){"private-user:#{user.id + 1}"}

      it 'calls failure' do
        service.success do
          raise 'it should not succeed'
        end

        service.failure do
          expect(:called).to eq(:called)
        end

        service.call
      end
    end
  end
end
