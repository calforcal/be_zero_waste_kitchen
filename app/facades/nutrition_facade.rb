class NutritionFacade
  def initialize(search=nil)
    @search = search
  end

  def total_ingredients
    service = NutritionService.new
    details = service.ingredients_weight(@search)

    @weight = Nutrition.new(details)
  end
end