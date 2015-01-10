class CreateModifiedFiles < ActiveRecord::Migration
  def change
    create_table :modified_files do |t|
      t.string :name, null: false
      t.integer :lines, array: true, null: false
      t.references :lint_task, index: true, null: false

      t.timestamps
    end
  end
end
