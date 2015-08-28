module API
  module V1
    class RepositoriesController < JSONAPIController
    private

      def include_relationships
        %w(owner)
      end
    end
  end
end
