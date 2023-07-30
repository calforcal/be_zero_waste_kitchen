class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :user_recipes
  has_many :users, through: :user_recipes
  validates :name, presence: true
  validates :public_status, presence: true

  def self.find_name(name)
    where('name ILIKE ?', "%#{name}%")
  end

  def self.ingredient_search_details(ingredients)
    find_by_sql(["SELECT recipes.id, recipes.name, recipes.api_id from recipes
      JOIN recipe_ingredients ON recipes.id = recipe_ingredients.recipe_id
      JOIN ingredients ON recipe_ingredients.ingredient_id = ingredients.id
      WHERE(ingredients.name ILIKE ANY(ARRAY[?]))
      GROUP BY recipes.id
      ORDER BY COUNT(1) DESC", ingredients])
  end

end

# def self.ingredient_search_details(ingredients)
#   select('recipes.id, recipes.name, recipes.api_id')
#     .joins(:ingredients)
#     .where('ingredients.name ILIKE ANY(ARRAY[?])', ingredients)
#     .group('recipes.id')
#     .order('COUNT(1) DESC')
# end