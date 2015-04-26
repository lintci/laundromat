# Schedules work to be run for a build
class TaskScheduler
  def initialize(build)
    @build = build
  end

  def schedule_analysis
    task = build.create_analyze_task

    schedule(task)
  end

  def schedule_linting(group)
    task = build.create_lint_task(group)

    schedule(task)
  end

protected

  attr_reader :build

private

  def schedule(task)
    return unless available_workers?

    worker(task).perform_async(serialize(task))

    task
  end

  def available_workers?
    true
  end

  def worker(task)
    "#{task.type}RequestedWorker".constantize
  end

  def serialize(task)
    "#{task.type}Serializer".constantize.new(
      task,
      meta: {
        event: build.event,
        event_id: build.event_id,
        requested_at: Time.stamp
      }
    ).as_json
  end
end
