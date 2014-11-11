# Wraps a paylaod from Github
class Payload
  def initialize(data)
    @data = data
  end

  def pull_request
    PullRequest.new(data['pull_request']) if pull_request?
  end

  def pull_request?
    data['pull_request']
  end

  def full_name
    data['repository']['full_name']
  end

protected

  attr_reader :data
end
