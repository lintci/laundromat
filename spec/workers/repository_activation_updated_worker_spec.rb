require 'spec_helper'

describe RepositoryActivationUpdatedWorker do
  describe '#perform' do
    let(:user_id){1}
    let(:repository_id){1}
    subject(:worker){described_class.new}

    it 'delegates to the ProcessSourceFiles service' do
      expect(UpdateRepositoryActivation).to receive(:call).with(user_id, repository_id)

      worker.perform(user_id, repository_id)
    end
  end
end
