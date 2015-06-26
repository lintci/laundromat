module API
  module V1
    module Auth
      # Provides access to a user
      class PushersController < BaseController
        before_action :ensure_valid_access_token!

        def create
          render json: User.find(params[:id]), serializer: UserSerializer
        end
      end
    end
  end
end
