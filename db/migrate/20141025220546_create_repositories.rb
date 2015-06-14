class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name, null: false
      t.string :owner_name, null: false
      t.string :provider, null: false
      t.string :status, null: false
      t.text :public_key, null: false
      t.text :private_key, null: false
      t.references :owner, null: false, index: true

      t.timestamps
    end
    add_foreign_key :repositories, :owners
  end
end
