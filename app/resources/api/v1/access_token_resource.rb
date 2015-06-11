require 'jsonapi/resource'

module API
  module V1
    # Serializes access token to client
    class AccessTokenResource < JSONAPI::Resource
      attributes :id, :access_token, :expires_in

      has_one :user
    end
  end
end
