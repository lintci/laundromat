module API
  module V1
    class ActivationsController < BaseController
      def create
        activation = jsonapi_parse!(only: :repository)

        StartActivatingRepository.call(current_user, activation)

        head :accepted
      end

      def destroy
        StartDeactivatingRepository.call(current_user, params.require(:id))

        head :accepted
      end
    end
  end
end
