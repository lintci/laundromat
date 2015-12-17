# Repository owner
class Owner < ActiveRecord::Base
  include HasProvider

  has_many :repositories
  has_many :builds, through: :repositories
  has_many :tasks, through: :builds

  validates :name, presence: true
  validates :provider, presence: true

  default_scope{order(:created_at)}

  class << self
    def upsert_from_provider!(provider_repository)
      find_or_create_by!(name: provider_repository.owner_name, provider: provider_repository.provider.to_s)
    end
  end
end
