class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :tables do |t|
      t.string :name
      t.integer :seat_number
      t.boolean :active, default: true
      t.string :slug
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :tables, :deleted_at
    add_index :tables, :slug
  end
end
