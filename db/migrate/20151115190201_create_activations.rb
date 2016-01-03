class CreateActivations < ActiveRecord::Migration
  def change
    create_table :activations do |t|
      t.text :public_key, null: false
      t.text :private_key, null: false
      t.string :deploy_key_id, null: false
      t.string :webhook_id, null: false
      t.string :provider, null: false
      t.references :repository, null: false, type: :uuid, index: true, foreign_key: true

      t.timestamps null: false, index: true
    end
  end
end
