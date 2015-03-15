require 'command_service'

class StartTask < CommandService
  def initialize(data)
    @task = Task.find(data['task']['id'])
    @started_at = Time.from_stamp(data['meta']['started_at'])
  end

  def perform
    task.start!(started_at)
  end

protected

  attr_reader :task, :started_at
end
