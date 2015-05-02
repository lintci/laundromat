class CreateTaskSourceFiles < ActiveRecord::Migration
  def change
    create_table :task_source_files do |t|
      t.references :task, index: true
      t.references :source_file, index: true
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps null: false
    end
    add_foreign_key :task_source_files, :tasks
    add_foreign_key :task_source_files, :source_files
  end
end
