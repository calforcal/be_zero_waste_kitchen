class SpoonSearch
  def initialize(options = {})
    @ingredients = options[:ingredients]
    @api_id = options[:api_id].to_s
    @name = options[:name]
  end

  def spoon_service
    SpoonacularService.new
  end

  def ingredient_search
    recipes = spoon_service.recipes_by_ingredients(@ingredients)
    recipes_created = []
    recipes.map do |recipe|
      if !Recipe.find_by(api_id: recipe[:id].to_s)
        recipe_created = Recipe.create!(name: recipe[:title],
                                        api_id: recipe[:id].to_s,
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
    end
    Recipe.ingredient_search_details(@ingredients)
  end

  def recipe_by_id_ingredients_results
    recipe = spoon_service.recipe_by_id(@api_id)
    saved_recipe = Recipe.find_by(api_id: @api_id)
    instructions = []
    instructions_hash = recipe[:analyzedInstructions].first
    if instructions_hash
    instructions_hash[:steps].each do |step|
      instructions << step[:step] if step
    end
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
      if !Recipe.find_by(api_id: recipe[:id])
        Recipe.create!(name: recipe[:title],
                      api_id: recipe[:id].to_s,
                      image_url: recipe[:image],
                      user_submitted: false)
      end
    end
    Recipe.find_name(@name)
  end

  def recipe_by_id_name_results
    recipe = spoon_service.recipe_by_id(@api_id)
    saved_recipe = Recipe.find_by(api_id: @api_id)
    instructions = []
    instructions_hash = recipe[:analyzedInstructions]&.first
    if instructions_hash
      instructions_hash[:steps].each do |step|
        instructions << step[:step] if step
      end
    end
    recipe[:extendedIngredients]&.each do |ingredient|
      saved_recipe.ingredients.create!(name: ingredient[:name],
                                       units: ingredient[:amount],
                                       unit_type: ingredient[:unit])
    end
    saved_recipe.update(instructions: instructions.flatten,
                        cook_time: recipe[:readyInMinutes],
                        source_name: recipe[:sourceName],
                        source_url: recipe[:sourceUrl])
    saved_recipe
  end

  def ingredient_search_details
    recipes = ingredient_search
    recipes.map do |recipe|
      @api_id = recipe.api_id
      recipe_by_id_ingredients_results
    end
  end

  def name_search_details
    recipes = name_search
    recipes.map do |recipe|
      @api_id = recipe.api_id
      recipe_by_id_name_results
    end
  end
end
