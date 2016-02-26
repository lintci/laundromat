require 'spec_helper'

describe StartActivatingRepository do
  describe '#call' do
    let(:user){repository_access.user}
    let(:repository){repository_access.repository}
    subject(:service){described_class}

    context 'when access level is admin and repository is deactivated' do
      let!(:repository_access){create(:admin_repository_access)}

      it 'transitions repository to activating and enqueues the activation', :aggregate_failures do
        service.call(user, repository_id: repository.id)

        job = RepositoryActivationUpdatedWorker.jobs.last
        expect(job['args']).to eq([user.id, repository.id])
        expect(repository.reload).to be_activating
      end
    end

    context 'when access level is not admin' do
      let!(:repository_access){create(:write_repository_access)}

      it 'raises an InsufficientAccess error' do
        expect do
          service.call(user, repository_id: repository.id)
        end.to raise_error(Laundromat::InsufficientAccess, 'Needed admin access. Currently have write access.')
      end
    end

    context 'when repository is not deactivated' do
      let!(:repository_access){create(:admin_repository_access, repository: build(:repository, :activating))}

      it 'raises an InvalidTransition error' do
        expect do
          service.call(user, repository_id: repository.id)
        end.to raise_error(Laundromat::InvalidTransition, "Event 'activate' unable to transition from 'activating'. Repository must be 'disabled' to create an activation.")
      end
    end
  end
end
