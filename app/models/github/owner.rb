module Github
  class Owner
    def initialize(owner)
      @owner = owner
    end

    def name
      owner.login
    end

    def provider
      Provider[:github]
    end

  protected

    attr_reader :owner
  end
end
