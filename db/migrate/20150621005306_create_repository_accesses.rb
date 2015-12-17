class CreateRepositoryAccesses < ActiveRecord::Migration
  def change
    create_table :repository_accesses, id: :uuid do |t|
      t.string :access, null: false
      t.references :user, index: true, type: :uuid, foreign_key: true
      t.references :repository, index: true, type: :uuid, foreign_key: true

      t.timestamps null: false, index: true

      t.index [:user_id, :repository_id], unique: true
    end
  end
end
