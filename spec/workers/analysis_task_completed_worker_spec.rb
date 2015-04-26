require 'spec_helper'

describe AnalyzeTaskCompletedWorker do
  describe '#perform' do
    let(:event){{}}
    subject(:worker){described_class.new}

    it 'delegates to the ProcessSourceFiles service' do
      expect(ProcessSourceFiles).to receive(:call).with(event)

      worker.perform(event)
    end
  end
end
