class RepositoryAccess < ActiveRecord::Base
  LEVELS = [
    ADMIN = Access.new(level: Access::ADMIN),
    WRITE = Access.new(level: Access::WRITE),
    READ = Access.new(level: Access::READ)
  ]

  belongs_to :user, required: true
  belongs_to :repository, required: true

  validates :access, presence: true, inclusion: {in: LEVELS}

  after_initialize :set_access

  default_scope{order(:created_at)}

  delegate :admin?, :write?, :read?, to: :access

  class << self
    def upsert_access!(repository, access)
      repository_access = where(repository: repository).first_or_initialize
      repository_access.update_attributes!(access: access)
    end
  end

  def access
    Access.new(level: self[:access])
  end

  def access=(level)
    self[:access] = level.to_s
  end

private

  def set_access
    self[:access] ||= READ.to_s
  end
end
