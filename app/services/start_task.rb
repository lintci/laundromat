class StartTask
  def initialize(data)
    @data = data
  end

  def call
    ActiveRecord::Base.transaction do
      task.started_at = started_at
      task.start
      task.save!
    end
  end

protected

  attr_reader :data

private

  def started_at
    Time.iso8601(data['started_at'])
  end

  def task
    @task ||= Task.find(data['task_id'])
  end
end
