module API
  module V1
    module Auth
      # Authenticates user
      class TokensController < BaseController
        def create
          authenticate_user = AuthenticateUser.new(params.require(:provider), params.require(:code))

          authenticate_user.success{|token| render json: token, serializer: AccessTokenSerializer}
          authenticate_user.failure{|errors| render json: {errors: errors}, status: :unprocessable_entity}

          authenticate_user.call
        end
      end
    end
  end
end
