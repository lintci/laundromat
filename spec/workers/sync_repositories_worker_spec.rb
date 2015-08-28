require 'spec_helper'

describe SyncRepositoriesWorker do
  describe '#perform' do
    subject(:worker){described_class.new}
    let(:user_id){1}

    it 'delegates to the RequestBuild service' do
      expect(SyncRepositories).to receive(:call).with(user_id)

      worker.perform(user_id)
    end
  end
end
