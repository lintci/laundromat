class Repository < ActiveRecord::Base
  belongs_to :owner, required: true
  has_many :builds
  has_many :tasks, through: :builds

  validates_presence_of :name, :full_name

  def create_build!(event, payload)
    builds.create!(event: event, payload: payload)
  end
end
