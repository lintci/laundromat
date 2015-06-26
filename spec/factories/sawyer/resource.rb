FactoryGirl.define do
  factory :sawyer_resource, class: Sawyer::Resource do
    data({})
    agent{Sawyer::Agent.new('example.com/api')}

    skip_create
    initialize_with{new(agent, data)}
  end
end
