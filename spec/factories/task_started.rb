FactoryGirl.define do
  factory :task_started do
    started_at{Time.now}
    task nil
    task_id{1}

    skip_create
    initialize_with do
      TaskStarted.new(
        'task_id' => task ? task.id : task_id,
        'started_at' => started_at.iso8601
      )
    end
  end
end
