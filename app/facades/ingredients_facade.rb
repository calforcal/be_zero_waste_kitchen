class IngredientsFacade
  def initialize(search=nil)
    @search = search
  end

  def ingredients_list
    service = IngredientsService.new
    details = service.ingredients_index(@search)

    @ingredients = details[:common].map { |ingredient| IngredientList.new(ingredient) }
  end
end