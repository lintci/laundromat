class Categorization
  class Linter
    # {
    #   'name' => 'Rubocop',
    #   'language' => 'Ruby',
    #   'file_modifications' => {
    #     'bad.rb' => [1, 2, 3]
    #   }
    # }
    def initialize(data)
      @data = data
    end

    def name
      data['name']
    end

    def language
      data['language']
    end

    def each_file_modification
      data['file_modifications'].each do |name, modifications|
        yield ModifiedFile.new(name, modifications)
      end
    end

  protected

    attr_reader :data
  end
end
