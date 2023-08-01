class RecipeSearch
  attr_reader :name,
              :ingredients
  def initialize(params = {})
    @name = params[:search]
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
      recipes = Recipe.ingredient_search_details(@ingredients)
      if recipes.count >= 10
        recipes
      else
        SpoonSearch.new(ingredients: @ingredients).ingredient_search_details
      end
    end
  end
end
