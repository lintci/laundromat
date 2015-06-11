module API
  module V1
    class RepositoriesController < BaseController
      def index
        fetch = FetchRepositories.new(current_user)
        fetch.success{}
      end
    end
  end
end
