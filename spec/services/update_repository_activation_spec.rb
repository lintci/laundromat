require 'spec_helper'

describe UpdateRepositoryActivation do
  subject(:service){described_class}

  describe '#call' do
    context 'when repository is activating' do
      let(:repository){create(:repository, :activating)}
      let(:user){create(:user, :with_tokens, repositories: [repository])}

      it 'activates the repository' do
        expect_any_instance_of(Github::API).to receive(:add_lintci_to_repository) do |_api, repository, activation|
          expect(repository).to be_a(Repository)
          expect(activation).to be_a(Activation)

          activation.attributes = attributes_for(:activation)
        end

        expect(Pusher).to receive(:trigger) do |channel, event, data|
          expect(channel).to eq("private-repository@#{repository.id}")
          expect(event).to eq('data-updated')
          expect(data).to be_json_api_resource('repository').
                          including('owner', 'activation')
        end

        service.call(user.id, repository.id)

        expect(repository.reload.status).to eq('active')
        expect(repository.activation).to be_a(Activation)
      end
    end

    context 'when repository is deactivating' do
      let(:repository){create(:repository, :deactivating)}
      let(:user){create(:user, :with_tokens, repositories: [repository])}

      it 'deactivates the repository' do
        expect_any_instance_of(Github::API).to receive(:remove_lintci_from_repository).with(be_a(Repository), be_a(Activation))

        expect(Pusher).to receive(:trigger) do |channel, event, data|
          expect(channel).to eq("private-repository@#{repository.id}")
          expect(event).to eq('data-updated')
          expect(data).to be_json_api_resource('repository').
                          including('owner', 'activation')
        end

        service.call(user.id, repository.id)

        expect(repository.reload.status).to eq('inactive')
        expect(repository.activation).to be_nil
      end
    end

    context 'when repository is in any other state' do
      let(:repository){create(:repository, :inactive)}
      let(:user){create(:user, :with_tokens, repositories: [repository])}

      it 'does nothing' do
        expect(Pusher).to_not receive(:trigger)

        service.call(user.id, repository.id)

        expect(repository.reload.status).to eq('inactive')
      end
    end
  end
end
