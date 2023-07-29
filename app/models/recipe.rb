class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :user_recipes
  has_many :users, through: :user_recipes
  validates :name, presence: true
  validates :api_id, uniqueness: true
  validates :public_status, presence: true

  
end
