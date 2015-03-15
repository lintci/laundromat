require 'spec_helper'

describe ClassifyTaskCompletedWorker do
  describe '#perform' do
    let(:event){{}}
    subject(:worker){described_class.new}

    it 'delegates to the CompleteClassifyTask service' do
      expect(CompleteClassifyTask).to receive(:call).with(event)

      worker.perform(event)
    end
  end
end
