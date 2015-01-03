# Wraps a paylaod from Github
class Payload
  attr_accessor :data

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

  def ==(other)
    data == other.data
  end
end
