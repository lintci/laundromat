class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :language
      t.string :linter
      t.string :status
      t.string :type
      t.references :build, index: true

      t.timestamps
    end
  end
end
