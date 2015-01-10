class LintTask < Task
  has_many :modified_files

  def add_modified_files(linter)
    linter.each_modified_file do |file|
      modified_files.build(name: file.name, lines: file.lines)
    end
  end
end
