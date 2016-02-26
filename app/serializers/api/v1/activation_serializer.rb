module API
  module V1
    # Access token serializer
    class ActivationSerializer < ActiveModel::Serializer
      belongs_to :repository, serializer: API::V1::RepositorySerializer
    end
  end
end
