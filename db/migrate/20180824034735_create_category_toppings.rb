class CreateCategoryToppings < ActiveRecord::Migration[5.2]
  def change
    create_table :category_toppings do |t|
      t.references :category, foreign_key: true
      t.references :topping, foreign_key: true
      t.boolean :active, default: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
