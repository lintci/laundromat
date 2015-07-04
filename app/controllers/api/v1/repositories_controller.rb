module API
  module V1
    class RepositoriesController < BaseController
      def index
        render current_user.repositories, serializer: API::V1::RepositorySerializer
      end

      def update
        update = UpdateRepositoryActivation.call(current_user, params[:id], params.require(:repository).allow(:status))

        update.success{render status: :success}
        update.failure{}
      end
    end
  end
end
