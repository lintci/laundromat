class RepositoryAccess < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :repository, required: true

  validates :access, presence: true

  class << self
    def upsert_access!(repository, access)
      repository_access = where(repository: repository).first_or_initialize
      repository_access.update_attributes!(access: access)
    end
  end
end
