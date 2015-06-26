class AuthorizeChannel < CommandService
  callback :success, :failure

  def initialize(user, channel_name, socket_id)
    @user = user
    binding.pry
    @channel = Channel[channel_name]
    @socket_id = socket_id
  end

  def call
    if authorized?
      success(authorization)
    else
      failure
    end
  end

protected

  attr_reader :user, :channel, :socket_id

private

  def authorized?
    channel.authorized?(user)
  end

  def authorization
    Pusher.channel(channel.name).authenticate(socket_id)
  end
end
