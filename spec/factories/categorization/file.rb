FactoryGirl.define do
  factory :file, class: Categorization::ModifiedFile do
    name 'bad.rb'
    lines [1, 2, 3]

    skip_create
    initialize_with do
      Categorization::ModifiedFile.new(name, lines)
    end
  end
end
