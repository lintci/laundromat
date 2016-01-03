module Github
  class User
    include Virtus.value_object

    values do
      attribute :uid, String
      attribute :username, String
      attribute :email, String
    end

    def provider
      Provider[:github]
    end

    def with_email_from_api(emails)
      with(email: emails.find(&:primary).email)
    end

    class << self
      def from_api(user)
        new(
          uid: user.id,
          username: user.login,
          email: user.email
        )
      end
    end
  end
end
