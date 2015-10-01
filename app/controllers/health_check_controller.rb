class HealthCheckController < ActionController::API
  def up
    render text: 'up', status: :ok
  end
end
