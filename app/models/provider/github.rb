module Provider
  class Github < Base
    def abbr
      'gh'
    end

    def api(*args)
      ::Github::API.new(*args)
    end

    def service_api
      ::Github::API.service
    end
  end
end
