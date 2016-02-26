module API
  module V1
    class RepositoriesController < BaseController
      def index
        render json: current_user.repositories,
               each_serializer: API::V1::RepositorySerializer
      end

      def show
        render json: current_user.repositories.find(params.require(:id)),
               serializer: API::V1::RepositorySerializer
      end
    end
  end
end
