module API
  module V1
    # Authenticates user
    class TokensController < BaseController
      def create
        authenticate_user = AuthenticateUser.new(Provider[params[:provider]], params[:code])

        authenticate_user.success{|token| render json: token, serializer: AccessTokenSerializer}
        authenticate_user.failure{|errors| render json: {errors: errors}, status: :unprocessable_entity}

        authenticate_user.call
      end
    end
  end
end
