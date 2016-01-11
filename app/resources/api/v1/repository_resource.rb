# TODO: Prevent updating status when update in process

module API
  module V1
    class RepositoryResource < BaseResource
      class << self
        def records(options)
          options[:context][:current_user].repositories
        end

        def creatable_fields(_context)
          []
        end

        def updatable_fields(_context)
          %i(status)
        end
      end

      has_one :owner

      attributes :name, :owner_name, :provider, :status

      after_update :activation_updated

      def provider
        model.provider.to_s
      end

    private

      def activation_updated
        RepositoryActivationUpdatedWorker.perform_async(current_user.id, model.id)
      end
    end
  end
end
