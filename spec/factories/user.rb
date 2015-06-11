FactoryGirl.define do
  sequence(:uid, &:to_s)

  factory :user do
    username 'bob'
    provider 'github'
    uid
    email 'bob@gmail.com'

    trait :with_tokens do
      after(:build) do |user, _|
        old_token = build(:access_token, expires_at: 20.days.ago, user: user)
        current_token = build(:access_token, user: user)
        user.access_tokens = [old_token, current_token]
      end
    end
  end
end
