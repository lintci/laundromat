# Code repository
class Repository < ActiveRecord::Base
  include AASM
  include HasProvider

  belongs_to :owner, required: true
  has_many :builds
  has_many :tasks, through: :builds

  scope :by_name, ->(name){where(name: name)}

  validates :name, presence: true
  validates :owner_name, presence: true
  validates :provider, presence: true
  validates :status, presence: true
  validates :public_key, presence: true
  validates :private_key, presence: true

  after_initialize :generate_ssh_keys

  aasm column: :status do
    state :inactive, initial: true
    state :active

    event(:activate){transitions from: :inactive, to: :active}
    event(:deactive){transitions from: :active, to: :inactive}
  end

  class << self
    def upsert_from_provider!(provider_repository)
      owner = Owner.upsert_from_provider!(provider_repository.owner)
      owner.repositories.by_name(provider_repository.name).first_or_create! do |repo|
        repo.owner_name = provider_repository.owner_name
        repo.provider = provider_repository.provider
      end
    end
  end

  def create_build!(event, event_id, payload)
    builds.create!(event: event, event_id: event_id, payload: payload)
  end

private

  def generate_ssh_keys
    return if public_key? && private_key?

    key_pair = SSHKey.generate(passphrase: ENV.fetch('SSH_PASSPHRASE'), comment: 'LintCI')
    self.private_key = key_pair.private_key
    self.public_key = key_pair.ssh_public_key
  end
end
