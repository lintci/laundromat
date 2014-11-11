class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :full_name
      t.references :owner, index: true

      t.timestamps
    end
  end
end
