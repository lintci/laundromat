class SyncRepositories < CommandService
  def initialize(user_id)
    @user = User.includes(:access_token).find(user_id)
  end

  def call

  end

protected

  attr_reader :user
end
