class TaskStarted
  def initialize(data)
    @data = data
  end

  def task_id
    data['task_id']
  end

  def started_at
    Time.iso8601(data['started_at'])
  end

protected

  attr_reader :data
end
