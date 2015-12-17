class CreateTaskSourceFiles < ActiveRecord::Migration
  def change
    create_table :task_source_files, id: :uuid do |t|
      t.references :task, index: true, type: :uuid, foreign_key: true
      t.references :source_file, index: true, type: :uuid, foreign_key: true
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps null: false, index: true
    end
  end
end
