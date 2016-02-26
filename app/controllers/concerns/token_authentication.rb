module TokenAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :ensure_valid_access_token!
  end

private

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
