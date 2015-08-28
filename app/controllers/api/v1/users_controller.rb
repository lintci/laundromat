module API
  module V1
    # Provides access to a user
    class UsersController < JSONAPIController
      before_action :ensure_valid_access_token!

      def show
        render json: User.find(params[:id]), serializer: UserSerializer
      end
    end
  end
end
