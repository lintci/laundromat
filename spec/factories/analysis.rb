FactoryGirl.define do
  factory :analysis do
    task_id 1
    source_files do
      [
        attributes_for(:javascript_source_file),
        attributes_for(:ruby_source_file),
        attributes_for(:text_source_file)
      ]
    end

    skip_create
    initialize_with do
      Analysis.new(
        'task_id' => task_id,
        'source_files' => source_files
      )
    end
  end
end
