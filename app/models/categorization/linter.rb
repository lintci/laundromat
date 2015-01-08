class Categorization
  class Linter
    attr_reader :name, :language
    # {
    #   'name' => 'Rubocop',
    #   'language' => 'Ruby',
    #   'modified_files' => [{
    #      'name' => 'bad.rb',
    #      'lines' => [1, 2, 3]
    #    }]
    # }
    def initialize(data)
      @name, @language, @modified_files = data.values_at('name', 'language', 'modified_files')
    end

    def each_modified_file
      modified_files.each do |data|
        yield ModifiedFile.new(data)
      end
    end

  protected

    attr_reader :modified_files
  end
end
