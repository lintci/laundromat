class Owner < ActiveRecord::Base
  has_many :plans
  has_many :repositories
  has_many :builds, through: :repositories
  has_many :tasks, through: :builds

  def available_workers
    active_workers = tasks.where(status: :running).count

    total_workers - active_workers
  end
end
