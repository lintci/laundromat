require 'spec_helper'

describe PayloadReceivedWorker do
  describe '#perform' do
    subject(:worker){described_class.new}
    let(:event){'pull_request'}
    let(:event_id){'bdb6ec00-5284-11e4-8e22-6dacd62599e2'}
    let(:payload_data){json_fixture_file('github/pull_request_opened_payload.json')}

    it 'delegates to the BuildRequest service' do
      expect(BuildRequest).to receive(:call).with(event, event_id, payload_data)

      worker.perform(event, event_id, payload_data)
    end
  end
end
