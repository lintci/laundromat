class TaskScheduler
  def initialize(build)
    @build = build
  end

  def schedule_categorization
    task = build.create_categorization_task

    schedule(task)
  end

  def schedule_analysis(linter)
    task = build.create_analysis_task(linter)

    schedule(task)
  end

protected

  attr_reader :build

private

  def schedule(task)
    return unless available_workers?

    worker(task).perform_async(json(task))

    task
  end

  def available_workers?
    true
  end

  def worker(task)
    "#{task.type}RequestedWorker".constantize
  end

  def json(task)
    TaskSerializer.new(task).to_json
  end
end
