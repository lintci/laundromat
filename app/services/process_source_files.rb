require 'command_service'

# Runs after source files have been classified. Splits the source files into
# pieces of work that run concurrently as tasks.
class ProcessSourceFiles < CommandService
  def initialize(data)
    @classification = Classification.new(data['classification'])
    @meta = data['meta']
  end

  def perform
    create_source_files
    complete_classify_task
    groups = group_source_files
    schedule_lint_tasks(groups)
  end

protected

  attr_reader :meta, :classification

private

  def create_source_files
    build.source_files = classification.source_files
    build.save!
  end

  def complete_classify_task
    task.source_files = build.source_files
    task.succeed(meta)
    task.save!
  end

  def group_source_files
    FileTaskGrouper.new(build.source_files).groups
  end

  def schedule_lint_tasks(groups)
    scheduler = TaskScheduler.new(build)

    groups.each do |group|
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
