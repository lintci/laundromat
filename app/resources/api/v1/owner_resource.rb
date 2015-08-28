module API
  module V1
    class OwnerResource < BaseResource
      has_many :repositories

      attributes :name, :provider

      def provider
        @model.provider.name
      end

      class << self
        def updatable_fields(_context)
          []
        end

        def records(options)
          options[:context][:current_user].owners
        end
      end
    end
  end
end
