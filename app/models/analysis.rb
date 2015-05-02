# The result of analyzing files to determine their language, linter, etc...
class Analysis
  attr_reader :task_id, :source_files

  def initialize(data)
    @task_id = data['task_id']
    @source_files = build_source_files(data)
  end

private

  def build_source_files(data)
    data['source_files'].map do |source_file_data|
      SourceFile.new(source_file_data)
    end
  end
end
