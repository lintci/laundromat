class TaskScheduler
  def initialize(build)
    @build = build
  end

  def schedule_categorization
    task = build.create_categorization_task

    schedule(task)
  end

  def schedule_analysis(language, linter, file_modifications)
    task = build.create_analysis_task(language, linter, file_modifications)

    schedule(task)
  end

protected

  attr_reader :build

private

  def schedule(task)
    return unless available_workers?

    event_class = "#{task.type}RequestedEvent".constantize
    serializer_class = "#{task.type}Requested".constantize
    event_class.perform_async(serializer_class.new(task))

    true
  end

  def available_workers?
    true
  end
end
