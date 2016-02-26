module API
  module V1
    # Access token serializer
    class AccessTokenSerializer < ActiveModel::Serializer
      belongs_to :user, serializer: API::V1::UserSerializer

      attributes :access_token, :expires_in
    end
  end
end
