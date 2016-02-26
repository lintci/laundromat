module Helpers
  module Controllers
    delegate :current_user, to: :controller

    def stub_auth
      access_token = build(:access_token)
      user = access_token.user

      allow(controller).to receive(:access_token).and_return(access_token)

      define_singleton_method(:current_user){user}
    end

    def current_user
      raise 'You forgot to call stub_auth which sets up the user'
    end

    def json
      @json ||= JSON.parse(response.body)
    end
  end
end
