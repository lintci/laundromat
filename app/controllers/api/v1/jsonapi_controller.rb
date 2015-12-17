module API
  module V1
    # Base API
    class JSONAPIController < BaseController
      include JSONAPI::ActsAsResourceController

      abstract

      before_action :ensure_valid_access_token!

    private

      def context
        {current_user: current_user}
      end
    end
  end
end
