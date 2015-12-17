class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens, id: :uuid do |t|
      t.references :user, index: true, null: false, type: :uuid, foreign_key: true
      t.string :access_token, null: false, index: true, unique: true
      t.string :provider_token, null: false
      t.datetime :expires_at, null: false

      t.timestamps null: false, index: true
    end
  end
end
