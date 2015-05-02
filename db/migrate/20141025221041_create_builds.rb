class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string :event, null: false
      t.string :event_id, null: false
      t.json :payload, null: false
      t.references :repository, index: true, null: false

      t.timestamps
    end
    add_foreign_key :builds, :repositories
  end
end
