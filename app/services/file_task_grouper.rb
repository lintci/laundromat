class FileTaskGrouper
  def initialize(source_files)
    @source_files = source_files
  end

  def groups
    grouping = Hash.new do |hash, (source_type, tool)|
      hash[[source_type, tool]] = SourceFileGroup.new(tool, source_type)
    end

    source_files.each do |source_file|
      source_file.linters.each do |linter|
        next if unknown?(linter)

        grouping[[source_file.source_type, linter]] << source_file
      end
    end

    grouping.values
  end

protected

  attr_reader :source_files

private

  def unknown?(thing)
    thing =~ /^unknown$/i
  end
end
