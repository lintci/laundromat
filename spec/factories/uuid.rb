require 'securerandom'

FactoryGirl.define do
  sequence :uuid do
    SecureRandom.uuid
  end
end
