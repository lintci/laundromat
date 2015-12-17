# User
class User < ActiveRecord::Base
  include HasProvider

  module AccessTokensExtension
    def upsert_from_provider!(provider_access_token)
      access_token = active.first_or_initialize
      access_token.update_attributes!(provider_token: provider_access_token.access_token)
      access_token
    end
  end

  has_many :repository_accesses, dependent: :destroy
  has_many :repositories, through: :repository_accesses
  has_many :owners, through: :repositories
  has_many :builds, through: :repositories
  has_many :access_tokens, ->{extending AccessTokensExtension}, dependent: :destroy
  has_one :active_access_token, ->{active}, class_name: 'AccessToken'

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: {scope: :provider}
  validates :username, presence: true
  validates :email, presence: true

  default_scope{order(:created_at)}

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

  def resert_repository_access!(repository, access)
    repository_accesses.upsert_access!(repository, access)
  end

  def api
    provider.api(active_access_token.provider_token)
  end
end
