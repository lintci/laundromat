class Owner < ActiveRecord::Base
  has_many :repositories
  has_many :builds, through: :repositories
  has_many :tasks, through: :builds

  validates_presence_of :name

  def available_workers?
    active_workers = tasks.where(status: :running).count

    total_workers - active_workers > 0
  end
end
