class AnalysisTask < Task
  has_many :modified_files

  def add_file_modifications(linter)
    linter.each_file_modification do |file|
      modified_files.build(name: file.name, lines: file.lines)
    end
  end
end
