module Channel
  class Repository < Base
    def authorized?(user)
      user.repositories.exists?(id: id)
    end
  end
end
