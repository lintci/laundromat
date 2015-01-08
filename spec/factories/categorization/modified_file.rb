FactoryGirl.define do
  factory :categorization_modified_file, class: Categorization::ModifiedFile do
    name 'bad.rb'
    lines [1, 2, 3]

    skip_create
    initialize_with do
      Categorization::ModifiedFile.new(
        'name' => name,
        'lines' => lines
      )
    end
  end
end
