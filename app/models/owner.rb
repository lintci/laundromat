# Repository owner
class Owner < ActiveRecord::Base
  has_many :repositories
  has_many :builds, through: :repositories
  has_many :tasks, through: :builds

  validates :name, presence: true

  class << self
    def upsert_from_provider!(provider_owner)
      find_or_create_by!(name: provider_owner.name)
    end
  end
end
