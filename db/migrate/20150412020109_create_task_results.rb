class CreateTaskResults < ActiveRecord::Migration
  def change
    create_table :task_results do |t|
      t.references :task, index: true
      t.references :source_file, index: true

      t.timestamps null: false
    end
    add_foreign_key :task_results, :tasks
    add_foreign_key :task_results, :source_files
  end
end
