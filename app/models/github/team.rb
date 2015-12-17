module Github
  class Team
    SERVICE_NAME = ENV.fetch('SERVICE_TEAM')

    include Virtus.value_object

    values do
      attribute :id, String
      attribute :name, String
      attribute :access, RepositoryAccess::Access
      attribute :privacy, String
    end

    def lintci?
      name.downcase == SERVICE_NAME.downcase
    end

    def admin?
      access == RepositoryAccess::ADMIN
    end

    class << self
      def from_api(api_team)
        new(
          id: api_team.id,
          name: api_team.name,
          access: access_from_api(api_team.permission),
          privacy: api_team.privacy
        )
      end

      def access_from_api(api_permission)
        case api_permission
        when 'admin'
          RepositoryAccess::ADMIN
        when 'push'
          RepositoryAccess::WRITE
        else
          RepositoryAccess::READ
        end
      end
    end
  end
end
