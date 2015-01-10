FactoryGirl.define do
  factory :classification_modified_file, class: Classification::ModifiedFile do
    name 'bad.rb'
    lines [1, 2, 3]

    skip_create
    initialize_with do
      Classification::ModifiedFile.new(
        'name' => name,
        'lines' => lines
      )
    end
  end
end
