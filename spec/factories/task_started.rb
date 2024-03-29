FactoryGirl.define do
  factory :task_started, class: Hash do
    started_at{Time.now}
    task{build(:analyze_task)}

    skip_create
    initialize_with do
      {
        'task' => {
          'id' => task.id,
          'type' => task.type,
          'language' => task.language,
          'tool' => task.tool
        },
        'meta' => {
          'event' => 'pull_request',
          'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
          'started_at' => started_at.stamp
        }
      }
    end
  end
end
