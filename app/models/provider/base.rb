module Provider
  class Base
    delegate :to_sym, to: :name

    def human_name
      self.class.name.gsub('Provider::', '')
    end

    def name
      human_name.underscore
    end
    alias_method :to_s, :name

    def abbr
      raise NotImplementedError, 'Subclass must define abbr.'
    end
  end
end
