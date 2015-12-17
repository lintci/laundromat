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

    class << self
      def from_api(user, emails)
        new(
          uid: user.id,
          username: user.login,
          email: email_from_api(user, emails)
        )
      end

    private

      def email_from_api(user, emails)
        if user.email.present?
          user.email
        else
          emails.find(&:primary).email
        end
      end
    end
  end
end
