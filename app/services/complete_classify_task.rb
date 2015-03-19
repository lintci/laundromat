require 'command_service'

class CompleteClassifyTask < CommandService
  def initialize(data)
    @classification = Classification.new(data['classification'])
    @meta = data['meta']
  end

  def perform
    complete_classify_task
    schedule_lint_tasks
  end

protected

  attr_reader :meta, :classification

private

  def complete_classify_task
    task.succeed(meta)
    task.save!
  end

  def schedule_lint_tasks
    scheduler = TaskScheduler.new(build)

    classification.each_group do |group|
      scheduler.schedule_linting(group)
    end
  end

  def task
    @task ||= Task.includes(:build).find(classification.task_id)
  end

  def build
    task.build
  end
end
