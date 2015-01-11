class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :language
      t.string :tool
      t.string :status, null: false
      t.string :type, null: false
      t.references :build, index: true, null: false
      t.datetime :started_at
      t.datetime :finished_at
      t.timestamps
    end
  end
end
