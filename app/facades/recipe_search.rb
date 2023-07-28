class RecipeSearch
  def spoon_service 
    SpoonacularService.new
  end

  def ingredient_search(ingredients)
    recipes = spoon_service.recipes_by_ingredients(ingredients)
    recipes.each do |recipe|
      Recipe.create!(name: recipe[:title], 
                    instructions: , 
                    image_url: , 
                    api_rating: , 
                    cook_time: , 
                    source_name: , 
                    source_url: ,
                    user_submitted: false)
    end
  end
end