module Github
  class AccessToken
    include Virtus.value_object

    values do
      attribute :access_token, String
      attribute :scope, String
    end

    class << self
      def from_api(api_authorization)
        new(
          access_token: api_authorization.access_token,
          scope: api_authorization.scope
        )
      end
    end
  end
end
