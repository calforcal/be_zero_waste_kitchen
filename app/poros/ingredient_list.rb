class IngredientList
  attr_reader :name, :id
  def initialize(details)
    @id = id
    @name = details[:food_name]
  end
end