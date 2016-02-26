module API
  module V1
    # Provides access to a user
    class UsersController < BaseController
      def show
        render json: current_user, serializer: UserSerializer
      end
    end
  end
end
