module API
  module V1
    class OwnerResource < BaseResource
      readonly

      has_many :repositories

      attributes :name, :provider

      def provider
        @model.provider.name
      end

      class << self
        def records(options)
          options[:context][:current_user].owners
        end
      end
    end
  end
end
