class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners, id: :uuid do |t|
      t.string :name, null: false
      t.string :provider, null: false
      t.boolean :organization, null: false, default: false

      t.timestamps null: false, index: true
    end
  end
end
