class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :username, null: false, index: true
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :email, null: false

      t.timestamps null: false, index: true

      t.index [:uid, :provider], unique: true
    end
  end
end
