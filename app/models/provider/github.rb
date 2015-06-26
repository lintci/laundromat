module Provider
  class Github < Base
    def abbr
      'gh'
    end

    def api(*args)
      ::Github::API.new(*args)
    end
  end
end
