class SpoonSearch
  def initialize(options = {})
    @ingredients = options[:ingredients]
    @api_id = options[:api_id]
    @name = options[:name]
  end

  def spoon_service
    SpoonacularService.new
  end

  def ingredient_search
    recipes = spoon_service.recipes_by_ingredients(@ingredients)
    recipes_created = []
    recipes.map do |recipe|
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
      recipes_created << recipe_created
    end
    recipes_created
  end

  def recipe_by_id
    recipe = spoon_service.recipe_by_id(@api_id)
    saved_recipe = Recipe.find_by(api_id: @api_id)
    instructions = []
    recipe[:analyzedInstructions].first[:steps].each do |step|
      instructions << step[:step] if step
    end
    saved_recipe.update(instructions: instructions.flatten,
                        cook_time: recipe[:readyInMinutes],
                        source_name: recipe[:sourceName],
                        source_url: recipe[:sourceUrl])
    saved_recipe
  end

  def name_search
    recipes = spoon_service.recipes_by_name(@name)
    recipes_found = recipes[:results].map do |recipe|
      Recipe.create!(name: recipe[:title],
                    api_id: recipe[:id].to_s,
                    image_url: recipe[:image])
    end
  end

  def ingredient_search_details
    recipes = ingredient_search
    recipes.map do |recipe|
      @api_id = recipe.api_id
      recipe_by_id
    end
  end

  def name_search_details
    recipes = name_search
    recipes.map do |recipe|
      @api_id = recipe.api_id
      recipe_by_id
    end
  end
end
