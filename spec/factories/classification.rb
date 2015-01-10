FactoryGirl.define do
  factory :classification do
    task_id 1
    finished_at{Time.now}
    linters [{
      'name' => 'Rubocop',
      'language' => 'Ruby',
      'file_modifications' => {
        'bad.rb' => [1, 2, 3]
      }
    }]

    skip_create
    initialize_with do
      Classification.new(
        'task_id' => task_id,
        'finished_at' => finished_at.iso8601,
        'linters' => linters
      )
    end
  end
end
