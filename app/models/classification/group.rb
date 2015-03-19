class Classification
  class Group
    attr_reader :linter, :language

    def initialize(data)
      @linter, @language, @modified_files = data.values_at('linter', 'language', 'modified_files')
    end

    def skip?
      [linter, language].any?{|thing| thing =~ /unknown/i}
    end

    def each_modified_file
      modified_files.each do |data|
        yield Classification::ModifiedFile.new(data)
      end
    end

    def ==(other)
      linter == other.linter &&
        language == other.language &&
        modified_files == other.modified_files
    end

  protected

    attr_reader :modified_files
  end
end
