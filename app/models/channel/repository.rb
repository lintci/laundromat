module Channel
  class Repository < Base
    def authorized?(user)
      user.repositories.exist?(id: id)
    end
  end
end
