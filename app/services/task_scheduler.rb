class TaskScheduler
  def initialize(build)
    @build = build
  end

  def schedule_categorization
    task = build.create_categorization_task

    schedule{CategorizationTaskRequested.}
  end

  def schedule_analysis
    task = build.tasks.create!(type: 'AnalysisTask')

    schedule{}
  end

protected

  attr_reader :build

private

  def schedule
    return unless available_workers?

    yield
  end

  def available_workers?
    build.owner.available_workers?
  end
end
