# Repository owner
class Owner < ActiveRecord::Base
  has_many :repositories
  has_many :builds, through: :repositories
  has_many :tasks, through: :builds

  validates :name, presence: true
end
