class CompleteCategorizationTask < CommandService
  def initialize(data)
    @categorization = Categorization.new(data)
  end

  def call
    transaction do
      complete_categorization_task
      schedule_analysis_tasks
    end
  end

protected

  attr_reader :data

private

  def complete_categorization_task
    task.finished_at = categorization.finished_at
    task.succeed
    task.save!
  end

  def schedule_analysis_tasks
    scheduler = TaskScheduler.new(build)

    categorization.each_linter do |linter|
      scheduler.schedule_analysis(linter)
    end
  end

  def task
    @task ||= Task.includes(:build).find(categorization.task_id)
  end

  def build
    task.build
  end
end
