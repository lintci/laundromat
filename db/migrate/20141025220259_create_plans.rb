class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.integer :cost, null: false
      t.integer :workers, null: false

      t.timestamps
    end
  end
end
