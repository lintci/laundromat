# TODO: Prevent updating status when update in process

module API
  module V1
    class RepositoryResource < BaseResource
      class << self
        def records(options)
          options[:context][:current_user].repositories
        end

        def creatable_fields
          []
        end

        def updatable_fields
          %i(status)
        end
      end

      has_one :owner

      attributes :name, :provider, :status

      after_update :activation_updated

      def provider
        model.provider.to_s
      end

    private

      def activation_updated
        RepositoryActivationUpdatedWorker.perform_async(model.id)
      end
    end
  end
end
