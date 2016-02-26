module API
  module V1
    # User serializer
    class UserSerializer < ActiveModel::Serializer
      has_many :repositories, serializer: API::V1::RepositorySerializer
      has_one :active_access_token, key: :access_token, serializer: API::V1::AccessTokenSerializer

      attributes :id, :username, :email

      attribute :provider do
        object.provider.name
      end
    end
  end
end
