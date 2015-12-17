class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds, id: :uuid do |t|
      t.string :event, null: false
      t.string :event_id, null: false
      t.json :payload, null: false
      t.references :repository, index: true, null: false, type: :uuid, foreign_key: true

      t.timestamps null: false, index: true
    end
  end
end
