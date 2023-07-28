class RecipeSearch

  def initialize(options = {})
    @ingredients = options[:ingredients]
    @api_id = options[:api_id]
  end
  
  def spoon_service 
    SpoonacularService.new
  end

  def ingredient_search
    recipes = spoon_service.recipes_by_ingredients(@ingredients)
    recipes.each do |recipe|
      recipe_created = Recipe.create!(name: recipe[:title], 
        api_id: recipe[:id], 
        image_url: recipe[:image], 
        user_submitted: false)
      recipe[:usedIngredients].map do |ingredient|
      recipe_created.ingredients.create!(name: ingredient[:name],
                                                unit_type: ingredient[:unitShort],
                                                units: ingredient[:amount])
        recipe[:missedIngredients].map do |ingredient|
        recipe_created.ingredients.create!(name: ingredient[:name],
                                                  unit_type: ingredient[:unitShort],
                                                  units: ingredient[:amount])
        end
      end
    end
  end

  def recipe_by_id
    recipe = spoon_service.recipe_by_id(@api_id)
    saved_recipe = Recipe.find_by(api_id: @api_id)
    instructions = []
    recipe[:analyzedInstructions]&[:steps].each do |step|
      instructions << step&[:step]
    end
    require 'pry'; binding.pry
    saved_recipe.update(instructions: instructions.flatten,
                        cook_time: recipe[:readyInMinutes],
                        source_name: recipe[:sourceName], 
                        source_url: recipe[:sourceUrl])
  end
end