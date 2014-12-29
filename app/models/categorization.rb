class Categorization
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

  def task_id
    data['task_id']
  end

  def finished_at
    Time.iso8601(data['finished_at'])
  end

  def each_linter
    data['linters'].each do |linter_data|
      yield Categorization::Linter.new(linter_data)
    end
  end

protected

  attr_reader :data
end
