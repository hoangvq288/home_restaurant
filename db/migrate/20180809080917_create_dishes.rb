class CreateDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|
      t.references :category, foreign_key: true
      t.string :name
      t.integer :price
      t.text :description
      t.string :slug
      t.boolean :active, default: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
