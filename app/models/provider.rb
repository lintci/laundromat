module Provider
  class << self
    def [](name)
      @providers[name]
    end

    def add(provider)
      @providers ||= {}
      @providers[provider.to_s] = provider
      @providers[provider.to_sym] = provider
      @providers[provider.abbr] = provider
      @providers[provider.abbr.to_sym] = provider
    end
  end

  add(Provider::Github.new)
end
