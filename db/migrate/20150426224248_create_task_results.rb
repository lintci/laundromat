class CreateTaskResults < ActiveRecord::Migration
  def change
    create_table :task_results do |t|
      t.references :task, index: true
      t.references :violation, index: true

      t.timestamps null: false
    end
    add_foreign_key :task_results, :tasks
    add_foreign_key :task_results, :violations
  end
end
