class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :name, null: false
      t.string :provider, null: false
      t.boolean :organization, null: false, default: false

      t.timestamps
    end
  end
end
