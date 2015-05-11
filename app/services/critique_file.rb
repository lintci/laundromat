require 'command_service'

# Provides feedback on code changes
class CritiqueFile < CommandService
  def initialize(data)
    @task = Task.find(data['meta']['task_id'])
    @source_file = SourceFile.find(data['source_file']['id'])
    @violations = build_violations(data['source_file']['violations'])
    @meta = data['meta']
  end

  def perform
    transaction do
      record_violations

      comment_on_pull_request if pull_request?
    end
  end

protected

  attr_reader :task, :source_file, :violations, :meta

private

  def record_violations
    task.add_violations(source_file, violations, started_at, finished_at)
  end

  def comment_on_pull_request
    violations_by_line do |line, line_violations|
      pull_request.comment(source_file, line, line_violations)
    end
  end

  def started_at
    Time.from_stamp(meta['started_at'])
  end

  def finished_at
    Time.from_stamp(meta['finished_at'])
  end

  def build_violations(violations_data)
    violations_data.map(&Violation.method(:new))
  end

  def pull_request
    source_file.build.payload.pull_request
  end
  alias_method :pull_request?, :pull_request

  def violations_by_line
    violations.group_by(&:line).each(&Proc.new)
  end
end
