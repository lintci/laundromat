require 'command_service'

# Provides feedback on code changes
class CritiqueFile < CommandService
  def initialize(data)
    @task = Task.find(data['meta']['task_id'])
    @source_file = SourceFile.find(data['source_file']['id'])
    @violations = build_violations(data['source_file']['violations'])
  end

  def perform
    transaction do
      source_file.add_violations(violations)
      task.add_violations(violations)

      if pull_request?
        violations_by_line do |line, line_violations|
          pull_request.comment(source_file, line, line_violations)
        end
      end
    end
  end

protected

  attr_reader :source_file, :violations

private

  def build_violations(violations_data)
    violations_data.map(&Violation.method(:new))
  end

  def pull_request
    source_file.build.pull_request
  end
  alias_method :pull_request?, :pull_request

  def violations_by_file
    violations.group_by(&:line).each(&Proc.new)
  end
end
