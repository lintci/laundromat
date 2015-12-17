class CreateViolations < ActiveRecord::Migration
  def change
    create_table :violations, id: :uuid do |t|
      t.integer :line
      t.integer :column
      t.integer :length
      t.string :rule
      t.string :severity
      t.text :message, null: false
      t.references :source_file, index: true, type: :uuid, foreign_key: true

      t.timestamps null: false, index: true
    end
  end
end
