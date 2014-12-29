class Owner < ActiveRecord::Base
  has_many :repositories
  has_many :builds, through: :repositories
  has_many :tasks, through: :builds

  validates_presence_of :name

  def available_workers?
    # TODO: Something like this. Total workers would come from the plan.
    # active_workers = tasks.total_running

    # total_workers - active_workers > 0
    true
  end
end
