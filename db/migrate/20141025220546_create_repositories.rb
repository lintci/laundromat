class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name, null: false
      t.string :owner_name, null: false
      t.string :host, null: false
      t.string :slug, null: false, index: {unique: true}
      t.string :status, null: false
      t.references :owner, null: false, index: true

      t.timestamps
    end
    add_foreign_key :repositories, :owners
  end
end
