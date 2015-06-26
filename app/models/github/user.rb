module Github
  class User
    def initialize(user, emails)
      @user = user
      @emails = Array(emails)
    end

    def uid
      user.id.to_s
    end

    def email
      if user.email.present?
        user.email
      else
        emails.find(&:primary).email
      end
    end

    def provider
      Provider[:github]
    end

    def username
      user.login
    end

  protected

    attr_reader :user, :emails
  end
end
