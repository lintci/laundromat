class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :language
      t.string :tool
      t.string :status, null: false
      t.string :type, null: false
      t.references :build, index: true, null: false, type: :uuid, foreign_key: true
      t.datetime :scheduled_at
      t.datetime :started_at
      t.datetime :finished_at
      t.timestamps null: false, index: true
    end
  end
end
