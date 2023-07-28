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
      recipe_created = Recipe.create!(name: recipe[:title], 
        api_id: recipe[:id], 
        image_url: recipe[:image], 
        user_submitted: false)
      recipe[:usedIngredients].map do |ingredient|
      recipe_created.ingredients.create!(name: ingredient[:name],
                                                unit_type: ingredient[:unitShort],
                                                units: ingredient[:amount])
      end
    end
  end
end