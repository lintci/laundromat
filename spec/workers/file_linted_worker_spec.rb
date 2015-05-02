require 'spec_helper'

describe FileLintedWorker do
  describe '#perform' do
    let(:event){{}}
    subject(:worker){described_class.new}

    it 'delegates to the ProcessSourceFiles service' do
      expect(CritiqueFile).to receive(:call).with(event)

      worker.perform(event)
    end
  end
end
