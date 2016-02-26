module API
  module V1
    # repository serializer
    class RepositorySerializer < ActiveModel::Serializer
      has_one :owner, serializer: API::V1::OwnerSerializer
      has_one :activation, serializer: API::V1::ActivationSerializer

      attributes :name, :owner_name, :status

      attribute :provider do
        object.provider.name
      end
    end
  end
end
