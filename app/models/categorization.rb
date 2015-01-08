class Categorization
  attr_reader :task_id

  def initialize(data)
    @task_id, @finished_at, @linters = data.values_at('task_id', 'finished_at', 'linters')
  end

  def finished_at
    Time.iso8601(@finished_at)
  end

  def each_linter
    linters.each do |data|
      yield Categorization::Linter.new(data)
    end
  end

protected

  attr_reader :linters
end
