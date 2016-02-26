module API
  module V1
    # Base API
    class BaseController < ActionController::API
      include TokenAuthentication
      include JSONAPIDeserialization

      skip_before_action :verify_authenticity_token

      rescue_from 'Provider::UnknownProviderError' do |exception|
        render json: {errors: [{status: '400', title: exception.message}]}, status: :bad_request
      end
    end
  end
end
