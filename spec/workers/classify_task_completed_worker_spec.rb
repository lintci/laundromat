require 'spec_helper'

describe ClassifyTaskCompletedWorker do
  describe '#perform' do
    let(:event){{}}
    subject(:worker){described_class.new}

    it 'delegates to the ProcessSourceFiles service' do
      expect(ProcessSourceFiles).to receive(:call).with(event)

      worker.perform(event)
    end
  end
end
