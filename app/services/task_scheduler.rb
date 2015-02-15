class TaskScheduler
  def initialize(build)
    @build = build
  end

  def schedule_classification
    task = build.create_classify_task

    schedule(task)
  end

  def schedule_linting(linter)
    task = build.create_lint_task(linter)

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
    TaskSerializer.new(task).serializable_hash
  end
end
