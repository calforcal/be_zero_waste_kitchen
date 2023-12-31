class User < ApplicationRecord
  has_many :saved_ingredients
  has_many :user_recipes
  has_many :recipes, through: :user_recipes
  validates :uid, presence: true

  def recipes_cooked
    recipes.select('recipes.name, recipes.api_id, recipes.id').where('user_recipes.cook_status = ?', 'true')
  end

  def recipes_created
    recipes.select('recipes.name', 'recipes.api_id', 'recipes.id').where('user_recipes.is_owner = ?', 'true')
  end

  def recipes_saved
    recipes.select('recipes.name', 'recipes.api_id', 'recipes.id').where('user_recipes.saved_status = ?', 'true')
  end

  def num_recipes_cooked
    recipes.select('recipes.name').where('user_recipes.cook_status = ?', 'true').count
  end

  def num_recipes_created
    recipes.select('recipes.name').where('user_recipes.is_owner = ?', 'true').count
  end

  def num_recipes_saved
    recipes.select('recipes.name').where('user_recipes.saved_status = ?', 'true').count
  end

  def emissions_reduction
    ingredient_string = ''
    saved_ingredients.each do |ingredient|
      ingredient_string << "#{ingredient.units.round(1)} #{ingredient.unit_type} #{ingredient.ingredient_name} "
    end

    @nutrition_facade = NutritionFacade.new(ingredient_string).total_ingredients
    @emissions_facade = EmissionsFacade.new(@nutrition_facade.total_weight_in_grams).total_emissions.co2_kg
  end

  def user_stats
    {
      recipes_created: num_recipes_created,
      recipes_cooked: num_recipes_cooked,
      kg_emissions_saved: emissions_reduction.round(2)
    }
  end
end
