module Github
  class Repository
    delegate :name, to: :repository

    def initialize(repository)
      @repository = repository
    end

    def owner_name
      owner.name
    end

    def owner
      Github::Owner.new(repository.owner)
    end

    def access
      perms = repository.permissions
      if perms.admin?
        RepositoryAccess::ADMIN
      elsif perms.push?
        RepositoryAccess::WRITE
      else
        RepositoryAccess::READ
      end
    end

    def provider
      Provider[:github]
    end

  protected

    attr_reader :repository
  end
end
