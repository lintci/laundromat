class CompleteCategorizationTask
  # {
  #   'task_id' => 1,
  #   'finished_at' => '2014-12-10T00:54:46Z'
  #   'linters' => [{
  #     'name' => 'Rubocop',
  #     'language' => 'Ruby',
  #     'file_modifications' => {
  #       'bad.rb' => [1, 2, 3]
  #     }
  #   }]
  # }
  def initialize(data)
    @data = data
  end

  def call
    ActiveRecord::Base.transaction do
      complete_categorization_task
      schedule_analysis_tasks
    end
  end

protected

  attr_reader :data

private

  def complete_categorization_task
    task.finished_at = finished_at
    task.succeed
    task.save!
  end

  def schedule_analysis_tasks
    scheduler = TaskScheduler.new(build)

    data['linters'].each do |linter|
      scheduler.schedule_analysis(*linter.values_at('language', 'name', 'file_modifications'))
    end
  end

  def finished_at
    Time.iso8601(data['finished_at'])
  end

  def task
    @task ||= Task.includes(:build).find(data['task_id'])
  end

  def build
    task.build
  end
end
