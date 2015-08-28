# Repository owner
class Owner < ActiveRecord::Base
  include HasProvider

  has_many :repositories
  has_many :builds, through: :repositories
  has_many :tasks, through: :builds

  validates :name, presence: true
  validates :provider, presence: true

  class << self
    def upsert_from_provider!(provider_owner)
      find_or_create_by!(name: provider_owner.name, provider: provider_owner.provider.to_s)
    end
  end
end
