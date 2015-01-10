FactoryGirl.define do
  factory :linter, class: Classification::Linter do
    name 'Rubocop'
    language 'Ruby'
    modified_files([{'name' => 'bad.rb', 'lines' => [1, 2, 3]}])

    skip_create
    initialize_with do
      Classification::Linter.new(
        'name' => name,
        'language' => language,
        'modified_files' => modified_files
      )
    end
  end
end
