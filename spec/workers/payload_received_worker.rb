require 'spec_helper'

describe PayloadReceivedWorker do
  describe '#perform' do
    subject(:worker){described_class.new}
    let(:event){'pull_request'}
    let(:payload_data){json_fixture_file('github/pull_request_opened_payload.json')}

    it 'delegates to the BuildRequest service' do
      expect(BuildRequest).to receive(:call).with(event, payload_data)

      worker.perform(event, payload_data)
    end
  end
end
