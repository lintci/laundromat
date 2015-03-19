FactoryGirl.define do
  factory :classification do
    task_id 1
    groups{[attributes_for(:group).stringify_keys]}

    skip_create
    initialize_with do
      Classification.new(
        'task_id' => task_id,
        'groups' => groups
      )
    end
  end
end
