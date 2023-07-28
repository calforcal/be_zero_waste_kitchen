require "rails_helper" 

RSpec.describe RecipeSearch do 
  describe "instance methods" do 
    it "will add recipes to cache", :vcr do 
      expect(Recipe.all.count).to eq(0)
      expect(Ingredient.all.count).to eq(0)
      expect(RecipeIngredient.all.count).to eq(0)
      query = ["potatoes", "onions"]
      recipes = RecipeSearch.new(ingredients: query).ingredient_search

      expect(Recipe.all.count).to_not eq(0)
      expect(Ingredient.all.count).to_not eq(0)
      expect(RecipeIngredient.all.count).to_not eq(0)

      expect(Recipe.first.name).to be_a(String)
      expect(Recipe.first.api_id).to be_a(String)
      expect(Recipe.first.image_url).to be_a(String)
      expect(Ingredient.first.name).to be_a(String)
      expect(Ingredient.first.units).to be_a(Float)
    end
  end
end