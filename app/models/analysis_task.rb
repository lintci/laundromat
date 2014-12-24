class AnalysisTask < Task
  has_many :modified_files

  def add_file_modifications(file_modifications)
    file_modifications.each do |file, lines|
      modified_files.build(name: file, lines: lines)
    end
  end
end
