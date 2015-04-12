class CreateSourceFiles < ActiveRecord::Migration
  def change
    create_table :source_files do |t|
      t.string :name, null: false
      t.string :sha, null: false
      t.string :source_type, null: false
      t.string :language
      t.string :linters, array: true, default: []
      t.integer :modified_lines, array: true, default: []
      t.boolean :generated, default: false
      t.boolean :vendored, default: false
      t.boolean :documentation, default: false
      t.boolean :binary, default: false
      t.boolean :image, default: false
      t.string :extension, null: false
      t.integer :size, null: false
      t.references :build, null: false

      t.timestamps
    end
  end
end
