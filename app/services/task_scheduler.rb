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

  def schedule(task)
    return unless available_workers?

    task.schedule!(scheduled_at: Time.stamp)
    worker(task).perform_async(serialize(task))

    task
  end

protected

  attr_reader :build

private

  # TODO: Implement worker limits
  def available_workers?
    true
  end

  def worker(task)
    "#{task.type}RequestedWorker".constantize
  end

  def serialize(task)
    includes = if task.type == 'LintTask'
      'build.pull_request,source_files'
    else
      'build.pull_request'
    end

    ActiveModel::SerializableResource.new(
      task,
      serializer: "Msg::V1::#{task.type}Serializer".constantize,
      include: includes,
      meta: {
        event: build.event,
        event_id: build.event_id,
        requested_at: Time.stamp
      }
    ).as_json
  end
end
