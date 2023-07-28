class RecipeSearch

  def initialize(options = {})
    @ingredients = options[:ingredients]

  end
  def spoon_service 
    SpoonacularService.new
  end

  def ingredient_search
    recipes = spoon_service.recipes_by_ingredients(@ingredients)
    recipes.each do |recipe|
      ingredients = []
      recipe[:usedIngredients].map { |ingredient| ingredients  << ingredient[:name]}
      recipe_created = Recipe.create!(name: recipe[:title], 
                    api_id: recipe[:id], 
                    image_url: recipe[:image], 
                    ingredients: ingredients,
                    user_submitted: false)
      recipe[:usedIngredients].map do |ingredient|
        ingredient_created = Ingredient.create!(name: ingredient[:name],
                                                units_type: ingredient[:unitShort],
                                                units: ingredient[:amount])
        RecipeIngredient.create!(recipe_id: recipe_created.id,
                                ingredient_id: ingredient_create.id)
      end
    end
  end
end