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

  def self.ingredient_search_details(ingredients)
    select('recipes.id, recipes.name, recipes.api_id')
      .joins(:ingredients)
      .where("ingredients.name ILIKE ANY(ARRAY[?])", ingredients)
      .group('recipes.id')
      .order('COUNT(1) DESC')
  end
end
