class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :name
  has_many :dishes
  has_many :category_toppings, dependent: :destroy
  has_many :toppings, through: :category_toppings
end
