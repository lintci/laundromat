module Channel
  PATTERN = /
    \A
    (?:(?<private>private)-)?
    (?<type>[^:]+):
    (?<id>.+)
    \z
  /x

  class << self
    def [](name)
      extract = name.match(PATTERN)
      type, id = extract[:type], extract[:id]

      @channel_type[type].try(:new, id)
    end

    def add(type)
      @channel_type ||= {}
      @channel_type[type.type] = type
    end
  end

  add(Channel::User)
  add(Channel::Repository)
end
