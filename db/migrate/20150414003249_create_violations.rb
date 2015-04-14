class CreateViolations < ActiveRecord::Migration
  def change
    create_table :violations do |t|
      t.integer :line
      t.integer :column
      t.integer :length
      t.string :rule
      t.string :severity
      t.text :message, null: false
      t.references :source_file, index: true

      t.timestamps null: false
    end
    add_foreign_key :violations, :source_files
  end
end
