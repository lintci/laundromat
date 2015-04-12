# Represents a tool and a group of files that will run in a task
class SourceFileGroup
  attr_reader :tool, :language, :source_files
  delegate :<<, :each, :size, to: :source_files

  def initialize(tool, language, source_files = [])
    @tool, @language = tool, language
    @source_files = source_files
  end

  def ==(other)
    other.is_a?(SourceFileGroup) &&
      tool == other.tool &&
      language == other.language &&
      source_files == other.source_files
  end
end
