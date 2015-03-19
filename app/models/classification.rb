class Classification
  attr_reader :task_id

  def initialize(data)
    @task_id, @groups = data.values_at('task_id', 'groups')
  end

  def each_group
    groups.each do |data|
      group = Classification::Group.new(data)

      yield group unless group.skip?
    end
  end

protected

  attr_reader :groups
end
