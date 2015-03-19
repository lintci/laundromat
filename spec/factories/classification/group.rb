FactoryGirl.define do
  factory :group, class: Classification::Group do
    linter 'RuboCop'
    language 'Ruby'
    modified_files{[attributes_for(:classification_modified_file).stringify_keys]}

    skip_create
    initialize_with do
      Classification::Group.new(
        'linter' => linter,
        'language' => language,
        'modified_files' => modified_files
      )
    end
  end
end
