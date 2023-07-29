class RecipeSearch

  def initialize(params = {})
    @name = params[:name]
    @ingredients = params[:ingredients]
  end

  def search
    if @name
      recipes = Recipe.find_name(@name)
      if recipes.count >= 10 
        recipes
      else
        SpoonSearch.new(name: @name).name_search_details
      end
    elsif @ingredients
      recipes = Recipe.find_ingredients(@ingredients)
      if recipes.count >=10
        recipes
      else
        SpoonSearch.new(ingredients: @ingredients).ingredient_search_details
      end
    end
  end
end