module API
  module V1
    class OwnersController < BaseController
      def index
        render json: current_user.owners,
               each_serializer: API::V1::OwnerSerializer
      end

      def show
        render json: current_user.owners.find(params.require(:id)),
               serializer: API::V1::OwnerSerializer
      end
    end
  end
end
