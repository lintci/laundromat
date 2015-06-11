# Code repository
class Repository < ActiveRecord::Base
  include AASM

  GITHUB = 'Github'
  HOSTS = {
    GITHUB => 'gh'
  }

  belongs_to :owner, required: true
  has_many :builds
  has_many :tasks, through: :builds

  validates :name, :owner_name, :host, :slug, :status, presence: true

  before_validation :set_slug

  aasm column: :status do
    state :inactive, initial: true
    state :active

    event(:activate){transitions from: :inactive, to: :active}
    event(:deactive){transitions from: :active, to: :inactive}
  end

  def create_build!(event, event_id, payload)
    builds.create!(event: event, event_id: event_id, payload: payload)
  end

private

  def set_slug
    self.slug ||= "#{HOSTS[host]}/#{owner}/#{name}"
  end
end
