class Dish < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :category
end
