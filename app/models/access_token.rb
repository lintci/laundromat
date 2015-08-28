# API Token
class AccessToken < ActiveRecord::Base
  belongs_to :user, required: true

  validates :access_token, presence: true, uniqueness: true
  validates :expires_at, presence: true

  before_validation :set_access_token, :set_expires_at, on: :create

  scope :active, ->{where('expires_at >= ?', Time.zone.now)}

  class << self
    def from_authorization(authorization)
      return if authorization.blank?

      access_token = authorization.gsub(/\ABearer /, '')
      active.find_by(access_token: access_token)
    end
  end

  def expires_in
    seconds_remaining = (expires_at - Time.zone.now).round
    seconds_remaining > 0 ? seconds_remaining : 0
  end

private

  def set_access_token
    return if access_token.present?

    loop do
      self.access_token = SecureRandom.hex
      break unless self.class.exists?(access_token: access_token)
    end
  end

  def set_expires_at
    return if expires_at.present?

    self.expires_at = 30.days.from_now
  end
end
