module Github
  class Repository
    include Virtus.value_object

    values do
      attribute :name, String
      attribute :access, String
      attribute :owner_name, String
    end

    def full_name
      "#{owner_name}/#{name}"
    end

    def provider
      Provider[:github]
    end

    class << self
      def from_api(api_repository)
        new(
          name: api_repository.name,
          owner_name: api_repository.owner.login,
          access: access_from_api(api_repository.permissions)
        )
      end

    private

      def access_from_api(api_permissions)
        if api_permissions.admin?
          RepositoryAccess::ADMIN
        elsif api_permissions.push?
          RepositoryAccess::WRITE
        else
          RepositoryAccess::READ
        end
      end
    end
  end
end
