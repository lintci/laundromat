class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories, id: :uuid do |t|
      t.string :name, null: false
      t.string :owner_name, null: false
      t.string :provider, null: false
      t.string :status, null: false
      t.references :owner, null: false, index: true, type: :uuid, foreign_key: true

      t.timestamps null: false, index: true
    end
  end
end
