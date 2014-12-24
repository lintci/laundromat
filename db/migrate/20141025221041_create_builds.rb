class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string :event, null: false
      t.json :payload, null: false
      t.references :repository, index: true, null: false

      t.timestamps
    end
  end
end
