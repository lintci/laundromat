module Channel
  class Base
    class << self
      def type
        name.demodulize.underscore
      end
    end

    attr_reader :id

    def initialize(id)
      @id = id
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
