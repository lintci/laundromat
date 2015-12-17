module API
  module V1
    class UserResource < BaseResource
      readonly

      attributes :username, :provider, :email

      def provider
        model.provider.to_s
      end

      class << self
        def records(options)
          options[:context][:current_user]
        end
      end
    end
  end
end
