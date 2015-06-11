module API
  module V1
    # User serializer
    class UserSerializer < ActiveModel::Serializer
      embed :ids

      attributes :id, :username
    end
  end
end
