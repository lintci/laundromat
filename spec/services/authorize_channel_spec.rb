require 'spec_helper'

describe AuthorizeChannel do
  let(:user){build(:user, id: generate(:uuid))}
  let(:socket_id){'1234.5678'} # Pusher validates socket ID's to match /\A\d+\.\d+\z/
  subject(:service){described_class.new(user, channel_name, socket_id)}

  describe '#call' do
    context 'when authorized' do
      let(:channel_name){"private-user@#{user.id}"}

      it 'calls success with the authentication' do
        service.success do |authentication|
          expect(authentication).to include(:auth)
        end

        service.failure do
          raise 'it should not fail'
        end

        service.call
      end
    end

    context 'when unauthorized' do
      let(:channel_name){"private-user@#{generate(:uuid)}"}

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
