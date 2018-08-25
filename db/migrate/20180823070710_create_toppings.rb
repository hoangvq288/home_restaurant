class CreateToppings < ActiveRecord::Migration[5.2]
  def change
    create_table :toppings do |t|
      t.string :name
      t.boolean :active, default: true
      t.integer :price, default: 0
      t.datetime :deleted_at
      t.string :slug

      t.timestamps
    end
  end
end
