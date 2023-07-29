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

    it "will add detailed data to a recipe", :vcr do 
      recipe = Recipe.create!(name: "Beans", api_id: "1099404", image_url: "sweeturl", user_submitted: false)

      RecipeSearch.new(api_id: recipe.api_id).recipe_by_id

      recipe.reload

      expect(recipe.instructions).to be_an(Array)
      expect(recipe.cook_time).to be_an(Integer)
      expect(recipe.source_name).to be_a(String)
      expect(recipe.source_url).to be_a(String)
    end

    it "will search by ingredients with detailed information", :vcr do 
      expect(Recipe.all.count).to eq(0)
      expect(Ingredient.all.count).to eq(0)
      expect(RecipeIngredient.all.count).to eq(0)

      query = ["potatoes", "onions"]
      recipes = RecipeSearch.new(ingredients: query).ingredient_search_details

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