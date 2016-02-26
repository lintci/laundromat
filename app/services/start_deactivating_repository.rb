require 'command_service'

# Transitions task to being started
class StartDeactivatingRepository < CommandService
  def initialize(user, activation_id)
    @user = user
    @activation_id = activation_id
  end

  def call
    verify_access!

    transition_repository_to_deactivating!

    enqueue_deactivation
  end

protected

  attr_reader :user, :activation_id

private

  delegate :repository, to: :repository_access
  delegate :activation, to: :repository

  def verify_access!
    return if repository_access.admin?

    raise Laundromat::InsufficientAccess.new(needed: RepositoryAccess::ADMIN, current: repository_access.access)
  end

  def transition_repository_to_deactivating!
    repository.deactivate!
  rescue AASM::InvalidTransition => error
    raise Laundromat::InvalidTransition.new(error, context: "Repository must be 'active' to destroy an activation.")
  end

  def enqueue_deactivation
    RepositoryActivationUpdatedWorker.perform_async(user.id, repository.id)
  end

  def repository_access
    @repository_access ||= user.repository_accesses.includes(repository: :activation)
                                                   .where(activations: {id: activation_id})
                                                   .first!
  end
end
