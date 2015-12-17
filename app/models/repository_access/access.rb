class RepositoryAccess < ActiveRecord::Base
  class Access
    include Virtus.value_object

    LEVELS = [
      ADMIN = 'admin',
      READ = 'read',
      WRITE = 'write'
    ]

    values do
      attribute :level, String
    end

    def admin?
      level == ADMIN
    end

    def write?
      level == WRITE
    end

    def read?
      level == READ
    end

    def to_s
      level
    end
  end
end
