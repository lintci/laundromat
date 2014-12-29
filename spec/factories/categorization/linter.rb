FactoryGirl.define do
  factory :linter, class: Categorization::Linter do
    name 'Rubocop'
    language 'Ruby'
    file_modifications('bad.rb' => [1, 2, 3])

    skip_create
    initialize_with do
      Categorization::Linter.new(
        'name' => name,
        'language' => language,
        'file_modifications' => file_modifications
      )
    end
  end
end
