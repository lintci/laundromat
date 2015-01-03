require 'spec_helper'

describe TaskStartedWorker do
  describe '#perform' do
    subject(:worker){described_class.new}
    let(:event){{}}

    it 'delegates to the TaskStartedWorker service' do
      expect(StartTask).to receive(:call).with(event)

      worker.perform(event)
    end
  end
end

