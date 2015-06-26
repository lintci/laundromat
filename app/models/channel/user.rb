module Channel
  class User < Base
    def authorized?(user)
      user.id == id
    end
  end
end
