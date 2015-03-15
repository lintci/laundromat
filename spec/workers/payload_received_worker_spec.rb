require 'spec_helper'

describe PayloadReceivedWorker do
  describe '#perform' do
    subject(:worker){described_class.new}
    let(:event){{}}

    it 'delegates to the RequestBuild service' do
      expect(RequestBuild).to receive(:call).with(event)

      worker.perform(event)
    end
  end
end
