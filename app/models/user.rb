# User
class User < ActiveRecord::Base
  include HasProvider

  has_many :access_tokens, dependent: :destroy

  validates :email, presence: true
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: {scope: :provider}
  validates :username, presence: true

  class << self
    def find_or_create_from_oauth(oauth)
      where(uid: oauth.id.to_s, provider: Provider[:github].to_s).first_or_create do |user|
        user.email = oauth.email
        user.username = oauth.login
      end
    end
  end

  def access_token
    access_tokens.active.first
  end
end
