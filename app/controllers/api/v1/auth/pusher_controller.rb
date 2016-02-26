module API
  module V1
    module Auth
      class PushersController < BaseController
        def create
          authorize = AuthorizeChannel.new(params[:channel_name], params[:socket_id])

          authorize.success{|authentication| render json: authentication}
          authorize.failure{render json: {errors: ['Forbidden']}, status: :forbidden}

          authorize.call
        end
      end
    end
  end
end
