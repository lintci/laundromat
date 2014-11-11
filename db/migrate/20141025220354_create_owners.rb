class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :name
      t.references :plan, index: true

      t.timestamps
    end
  end
end
