class CategoryTopping < ApplicationRecord
  belongs_to :category
  belongs_to :topping
end
