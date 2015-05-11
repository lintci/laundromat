require 'command_service'

# Processes the ruesult of linting a group of files
class ProcessLinting < CommandService
  def initialize(data)
    @linting = Linting.new(data['linting'])
    @task = Task.find(linting.task_id)
    @meta = data['meta']
  end

  def perform
    transaction do
      update_task_status

      schedule_queued_tasks
    end
  end

protected

  attr_reader :linting, :task, :meta

private

  def update_task_status
    if linting.clean?
      task.succeed!(meta)
    else
      task.failure!(meta)
    end
  end

  def schedule_queued_tasks
    QueuedTasksQuery.new(task.owner).find_each do |queued_task|
      return unless TaskScheduler.new(queued_task.build).schedule(queued_task)
    end
  end
end
