# Code repository
class Repository < ActiveRecord::Base
  include AASM
  include HasProvider

  belongs_to :owner, required: true
  has_one :activation
  has_many :builds
  has_many :tasks, through: :builds

  validates :name, presence: true
  validates :owner_name, presence: true
  validates :provider, presence: true
  validates :status, presence: true

  default_scope{order(:created_at)}
  scope :by_name, ->(name){where(name: name)}

  delegate :organization?, to: :owner
  delegate :public_key, :private_key, to: :activation, allow_nil: true

  aasm column: :status do
    state :inactive, initial: true
    state :activating
    state :active
    state :deactivating

    event(:activate){transitions from: :inactive, to: :activating}
    event(:activated){transitions from: :activating, to: :active}
    event(:deactive){transitions from: :active, to: :deactivating}
    event(:deactivated){transitions from: :deactivating, to: :inactive}
  end

  class << self
    def upsert_from_provider!(provider_repository)
      owner = Owner.upsert_from_provider!(provider_repository)
      owner.repositories.by_name(provider_repository.name).first_or_create! do |repo|
        repo.owner_name = provider_repository.owner_name
        repo.provider = provider_repository.provider
      end
    end
  end

  def create_build!(event, event_id, payload)
    builds.create!(event: event, event_id: event_id, payload: payload)
  end

  def full_name
    "#{owner_name}/#{name}"
  end
end
