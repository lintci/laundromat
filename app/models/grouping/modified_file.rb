class Classification
  class ModifiedFile
    attr_reader :name, :lines

    def initialize(data)
      @name, @lines = data.values_at('name', 'lines')
    end
  end
end
