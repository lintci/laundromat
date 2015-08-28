module API
  module V1
    class UserResource < BaseResource
      attributes :username, :provider, :email

      def provider
        model.provider.to_s
      end

      class << self
        def updatable_fields(_context)
          []
        end

        def records(options)
          options[:context][:current_user]
        end
      end
    end
  end
end
