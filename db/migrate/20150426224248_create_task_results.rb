class CreateTaskResults < ActiveRecord::Migration
  def change
    create_table :task_results, id: :uuid do |t|
      t.references :task, index: true, type: :uuid, foreign_key: true
      t.references :violation, index: true, type: :uuid, foreign_key: true

      t.timestamps null: false, index: true
    end
  end
end
