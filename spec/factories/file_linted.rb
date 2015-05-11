FactoryGirl.define do
  factory :file_linted, class: Hash do
    started_at{Time.now}
    finished_at{Time.now}
    lint_task{create(:lint_task)}
    source_file{create(:source_file)}
    violations_data{[attributes_for(:violation), attributes_for(:violation)]}

    skip_create
    initialize_with do
      source_file_data = source_file.attributes.deep_stringify_keys

      {
        'source_file' => source_file_data.merge('violations' => violations_data),
        'meta' => {
          'event' => 'pull_request',
          'event_id' => 'bdb6ec00-5284-11e4-8e22-6dacd62599e2',
          'task_id' => lint_task.id,
          'started_at' => started_at.stamp,
          'finished_at' => finished_at.stamp
        }
      }
    end
  end
end
