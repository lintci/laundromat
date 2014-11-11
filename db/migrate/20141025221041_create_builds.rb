class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.integer :number
      t.string :event
      t.json :payload
      t.references :repository, index: true

      t.timestamps
    end
  end
end
