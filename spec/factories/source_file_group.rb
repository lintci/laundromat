FactoryGirl.define do
  factory :source_file_group, aliases: [:ruby_source_file_group] do
    tool 'RuboCop'
    language 'Ruby'
    source_files{[build(:ruby_source_file)]}

    skip_create
    initialize_with{new(tool, language, source_files)}
  end
end
