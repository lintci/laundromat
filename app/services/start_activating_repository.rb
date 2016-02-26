require 'command_service'

# Transitions task to being started
class StartActivatingRepository < CommandService
  def initialize(user, activation)
    @user = user
    @repository_id = activation[:repository_id]
  end

  def call
    verify_access!

    transition_repository_to_activating!

    enqueue_activation
  end

protected

  attr_reader :user, :repository_id

private

  delegate :repository, to: :repository_access

  def verify_access!
    return if repository_access.admin?

    raise Laundromat::InsufficientAccess.new(needed: RepositoryAccess::ADMIN, current: repository_access.access)
  end

  def transition_repository_to_activating!
    repository.activate!
  rescue AASM::InvalidTransition => error
    raise Laundromat::InvalidTransition.new(error, context: "Repository must be 'disabled' to create an activation.")
  end

  def enqueue_activation
    RepositoryActivationUpdatedWorker.perform_async(user.id, repository.id)
  end

  def repository_access
    @repository_access ||= user.repository_accesses.includes(:repository).find_by!(repository_id: repository_id)
  end
end
