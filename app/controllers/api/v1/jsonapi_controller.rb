module API
  module V1
    # Base API
    class JSONAPIController < BaseController
      include JSONAPI::ActsAsResourceController

    private

      def context
        {current_user: current_user}
      end

      def setup_request
        params[:include] = CSV.generate_line(include_relationships) if include_relationships.any?

        super
      end

      def include_relationships
        []
      end
    end
  end
end
