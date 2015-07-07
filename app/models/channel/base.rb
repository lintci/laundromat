module Channel
  class Base
    class << self
      def type
        name.split('::').last.underscore
      end
    end

    attr_reader :id

    def initialize(id)
      @id = id.to_i
    end

    def type
      self.class.type
    end

    def name
      "private-#{type}@#{id}"
    end

    def authorized?(_user)
      raise NotImplementedError
    end
  end
end
