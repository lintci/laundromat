module API
  module V1
    # Access token serializer
    class OwnerSerializer < ActiveModel::Serializer
      has_many :repositories, serializer: API::V1::RepositorySerializer do
        object.user_repositories(scope)
      end

      attributes :name, :organization

      attribute :provider do
        object.provider.name
      end
    end
  end
end
