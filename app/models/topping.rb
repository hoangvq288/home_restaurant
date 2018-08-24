class Topping < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :category_toppings, dependent: :destroy
  has_many :categories, through: :category_toppings
end
