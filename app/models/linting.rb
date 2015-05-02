# The result of linting a group of files
class Linting
  attr_reader :task_id, :clean
  alias_method :clean, :clean?

  def initialize(data)
    @task_id, @clean = data.values_at('task_id', 'clean')
  end
end
