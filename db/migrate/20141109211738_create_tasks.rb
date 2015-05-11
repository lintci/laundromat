class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :language
      t.string :tool
      t.string :status, null: false
      t.string :type, null: false
      t.references :build, index: true, null: false
      t.datetime :scheduled_at
      t.datetime :started_at
      t.datetime :finished_at
      t.timestamps
    end
    add_foreign_key :tasks, :builds
  end
end
