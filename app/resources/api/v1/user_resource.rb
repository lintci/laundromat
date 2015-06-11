require 'jsonapi/resource'

module API
  module V1
    # Serializes access token to client
    class UserResource < JSONAPI::Resource
      attributes :id, :username

      has_one :access_token
    end
  end
end
