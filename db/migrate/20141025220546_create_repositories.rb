class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name, null: false
      t.string :full_name, null: false
      t.references :owner, index: true, null: false

      t.timestamps
    end
  end
end
