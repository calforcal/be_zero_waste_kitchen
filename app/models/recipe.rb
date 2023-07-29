class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :user_recipes
  has_many :users, through: :user_recipes
  validates :name, presence: true
  validates :public_status, presence: true

  def self.find_name(name)
    where("name ILIKE ?", "%#{name}%")
  end

  def ingredient_search_details

  end
end
