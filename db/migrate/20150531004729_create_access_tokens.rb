class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.references :user, index: true, null: false
      t.string :access_token, null: false, index: true, unique: true
      t.string :provider_token, null: false
      t.datetime :expires_at, null: false

      t.timestamps null: false
    end

    add_foreign_key :access_tokens, :users
  end
end
