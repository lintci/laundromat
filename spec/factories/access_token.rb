FactoryGirl.define do
  sequence :access_token do |n|
    n.to_s
  end

  sequence :provider_token do |n|
    n.to_s
  end

  factory :access_token do
    association :user, strategy: :build
    access_token{generate(:access_token)}
    provider_token
    expires_at{30.days.from_now}
  end
end
