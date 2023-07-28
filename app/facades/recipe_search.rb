class RecipeSearch
  def spoon_service 
    SpoonacularService.new
  end

  def ingredient_search(ingredients)
    spoon_service.recipes_by_ingredients(ingredients)
  end
end