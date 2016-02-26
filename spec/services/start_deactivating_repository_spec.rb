require 'spec_helper'

describe StartDeactivatingRepository do
  describe '#call' do
    let(:activation){repository.activation}
    let(:user){repository_access.user}
    let(:repository){create(:repository, :active)}
    subject(:service){described_class}

    context 'when access level is admin and repository is active' do
      let!(:repository_access){create(:admin_repository_access, repository: repository)}

      it 'transitions repository to activating and enqueues the activation', :aggregate_failures do
        service.call(user, activation.id)

        job = RepositoryActivationUpdatedWorker.jobs.last
        expect(job['args']).to eq([user.id, repository.id])
        expect(repository.reload).to be_deactivating
      end
    end

    context 'when access level is not admin' do
      let!(:repository_access){create(:write_repository_access, repository: repository)}

      it 'raises an InsufficientAccess error' do
        expect do
          service.call(user, activation.id)
        end.to raise_error(Laundromat::InsufficientAccess, 'Needed admin access. Currently have write access.')
      end
    end

    context 'when repository is not deactivated' do
      let(:repository){create(:repository, :deactivating)}
      let!(:repository_access){create(:admin_repository_access, repository: repository)}

      it 'raises an InvalidTransition error' do
        expect do
          service.call(user, activation.id)
        end.to raise_error(Laundromat::InvalidTransition, "Event 'deactivate' unable to transition from 'deactivating'. Repository must be 'active' to destroy an activation.")
      end
    end
  end
end
