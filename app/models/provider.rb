module Provider
  UnknownProviderError = Class.new(StandardError)

  class << self
    prepend

    def [](provider)
      providers[key(provider)]
    end

    def fetch(provider, &block)
      providers.fetch(key(provider), &block)
    rescue KeyError
      raise UnknownProviderError, "Received unknown provider: #{provider.inspect}"
    end

    def register(provider)
      self.providers ||= {}
      providers[provider.name] = provider
      providers[provider.abbr] = provider
    end

  protected

    attr_accessor :providers

  private

    def key(provider)
      provider.to_s.underscore
    end
  end

  register(Provider::Github.new)
end
