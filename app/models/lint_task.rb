# Task to run a linter
class LintTask < Task
  def add_violations(source_file, new_violations, started_at, finished_at)
    source_file.add_violations(new_violations)

    task_source_file = task_source_files.find_by(source_file_id: source_file)
    task_source_file.update_attributes!(started_at: started_at, finished_at: finished_at)

    violations.push(*new_violations)
  end
end
