module Github
  class AccessToken
    delegate :access_token, :scope, to: :token

    def initialize(access_token)
      @token = access_token
    end

  protected

    attr_reader :token
  end
end
