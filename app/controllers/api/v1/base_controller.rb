module API
  module V1
    # Base API
    class BaseController < ActionController::API
      skip_before_action :verify_authenticity_token

      rescue_from 'Provider::UnknownProviderError' do |exception|
        render json: {errors: [{status: '400', title: exception.message}]}, status: :bad_request
      end

    protected

      def ensure_valid_access_token!
        access_token || render_unauthorized
      end

      def access_token
        @access_token ||= AccessToken.from_authorization(request.authorization)
      end

      def current_user
        access_token.user if access_token
      end

      def render_unauthorized
        headers['WWW-Authenticate'] = 'Bearer realm="Application"'
        render json: {errors: ['Bad credentials']}, status: :unauthorized
      end
    end
  end
end
