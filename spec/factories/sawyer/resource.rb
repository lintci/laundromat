FactoryGirl.define do
  factory :sawyer_resource, class: Sawyer::Resource do
    data({})
    agent{Sawyer::Agent.new('example.com/api')}

    skip_create
    initialize_with{new(agent, data)}
  end

  factory :sawyer_resources, class: Array do
    data []

    skip_create
    initialize_with{Array(data).map{|resource| build(:sawyer_resource, data: resource)}}
  end
end
