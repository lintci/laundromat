FactoryGirl.define do
  factory :lint_task_completed, class: Hash do
    task_id 1
    clean false
    started_at{Time.stamp_time}
    finished_at{Time.stamp_time}

    skip_create
    initialize_with do
      {
        'linting' => {
          'task_id' => task_id,
          'clean' => clean
        },
        'meta' => {
          'event' => 'pull_request',
          'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
          'started_at' => started_at.stamp,
          'finished_at' => finished_at.stamp
        }
      }
    end
  end
end
