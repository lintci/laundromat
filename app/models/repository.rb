# Code repository
class Repository < ActiveRecord::Base
  belongs_to :owner, required: true
  has_many :builds
  has_many :tasks, through: :builds

  validates :name, :full_name, presence: true

  def create_build!(event, event_id, payload)
    builds.create!(event: event, event_id: event_id, payload: payload)
  end
end
