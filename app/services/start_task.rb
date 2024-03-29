require 'command_service'

# Transitions task to being started
class StartTask < CommandService
  def initialize(data)
    @task = Task.find(data['task']['id'])
    @meta = data['meta']
  end

  def perform
    task.start!(meta) if task.may_start?
  end

protected

  attr_reader :task, :meta
end
