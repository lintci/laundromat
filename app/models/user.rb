# User
class User < ActiveRecord::Base
  include HasProvider

  has_many :repository_accesses, dependent: :destroy
  has_many :repositories, through: :repository_accesses
  has_many :builds, through: :repositories
  has_many :access_tokens, dependent: :destroy
  has_one :active_access_token, ->{active}, class_name: 'AccessToken'

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: {scope: :provider}
  validates :username, presence: true
  validates :email, presence: true

  class << self
    def upsert_from_provider!(provider_user)
      scope = where(uid: provider_user.uid, provider: provider_user.provider.to_s)
      scope.first_or_create! do |user|
        user.email = provider_user.email
        user.username = provider_user.username
      end
    end
  end

  def upsert_access_token_from_provider!(provider_access_token)
    access_tokens.upsert_from_provider!(provider_access_token)
  end

  def upsert_repository_access!(repository, access)
    repository_accesses.upsert_access!(repository, access)
  end
end
