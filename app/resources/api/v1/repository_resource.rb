module API
  module V1
    class RepositoryResource < BaseResource
      has_one :owner

      attributes :name, :provider, :status

      after_save :update_repository_activation

      def provider
        model.provider.to_s
      end

      def update_repository_activation
        UpdateRepositoryActivation.new(current_user, model)
      end

      class << self
        def updatable_fields(_context)
          [:status]
        end

        def records(options)
          options[:context][:current_user].repositories
        end
      end
    end
  end
end
