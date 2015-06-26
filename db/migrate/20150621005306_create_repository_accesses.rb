class CreateRepositoryAccesses < ActiveRecord::Migration
  def change
    create_table :repository_accesses do |t|
      t.string :access, null: false
      t.references :user, index: true
      t.references :repository, index: true

      t.timestamps null: false

      t.index [:user_id, :repository_id]
    end
    add_foreign_key :repository_accesses, :users
    add_foreign_key :repository_accesses, :repositories
  end
end
