require 'jsonapi/resource'

module API
  module V1
    # Serializes access token to client
    class RepositoryResource < JSONAPI::Resource
      attributes :id, :name, :owner, :host, :status, :slug

      def owner
        @model.owner_name
      end

      class << self
        def updateable_fields(_)
          [:status]
        end

        def createable_fields(_)
          []
        end
      end
    end
  end
end
