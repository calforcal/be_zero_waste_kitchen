require "rails_helper" 

RSpec.describe RecipeSearch do 
  describe "instance methods" do 
    it "will add recipes to cache", :vcr do 
      expect(Recipe.all.count).to eq(0)
      query = ["potatoes", "onions"]
      recipes = RecipeSearch.new(ingredients: query).ingredient_search

      expect(Recipe.all.count).to_not eq(0)
      recipes.each do |recipe|
        expect(recipe).to be_a(Recipe)
        expect(recipe.api_id).to be_a(String)
        expect(recipe.image_url).to be_a(String)
        expect(recipe.ingredients).to be_an(Array)
        expect(recipe.ingredients.count > 0).to be(true)
      end
    end
  end
end