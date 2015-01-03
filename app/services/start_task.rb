require 'command_service'

class StartTask < CommandService
  def initialize(data)
    @event = TaskStarted.new(data)
  end

  def perform
    task.start!(event)
  end

protected

  attr_reader :event

private

  def task
    @task ||= Task.find(event.task_id)
  end
end
