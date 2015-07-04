class RepositoryAccess < ActiveRecord::Base
  READ = 'read'
  WRITE = 'write'
  ADMIN = 'admin'

  belongs_to :user, required: true
  belongs_to :repository, required: true

  validates :access, presence: true

  before_validation :set_access

  class << self
    def upsert_access!(repository, access)
      repository_access = where(repository: repository).first_or_initialize
      repository_access.update_attributes!(access: access)
    end
  end

private

  def set_access
    self.access ||= READ
  end
end
