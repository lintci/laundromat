module API
  module V1
    module Auth
      # Authenticates user
      class TokensController < BaseController
        skip_before_action :ensure_valid_access_token!

        def create
          authenticate_user = AuthenticateUser.new(params.require(:provider), params.require(:code))

          authenticate_user.success{|token| render json: token, serializer: API::V1::AccessTokenSerializer, include: %w(user)}
          #TODO: Revisit when ActiveModelSerializers supports errors.
          authenticate_user.failure{|errors| render json: {errors: errors}, status: :unprocessable_entity}

          authenticate_user.call
        end
      end
    end
  end
end
