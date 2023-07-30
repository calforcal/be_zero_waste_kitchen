require "rails_helper" 

RSpec.describe RecipeSearch do 
  describe "initialize" do 
    it "has attributes" do 
      search = RecipeSearch.new({name: "taco salad", ingredients: ["taco shells", "tomatoes", "onions"]})
      
      expect(search.name).to eq("taco salad")
      expect(search.ingredients).to be_an(Array)
      expect(search.ingredients[0]).to eq("taco shells")
    end
  end

  describe "instance methods" do 
    it "search with name" do 
      VCR.use_cassette("RecipeSearch/instance_methods/search_with_name", match_requests_on: [:path]) do 
        expect(Recipe.all.count).to eq(0)
        expect(Ingredient.all.count).to eq(0)
        expect(RecipeIngredient.all.count).to eq(0)

        params = {name: "tacos"}
        search = RecipeSearch.new(params)
        search.search

        expect(Recipe.all.count).to_not eq(0)
        
        expect(Recipe.first.name).to be_a(String)
        expect(Recipe.first.api_id).to be_a(String)
        expect(Recipe.first.image_url).to be_a(String)
      end
    end
    
    it "search with ingredients" do 
      VCR.use_cassette("RecipeSearch/instance_methods/search_with_ingredients", match_requests_on: [:path]) do 
        recipe_3 = Recipe.create!(name: 'Pasta', api_id: "1234567891234567892", instructions: ['1. Cook Pasta', '2. Cover in butter and cheese', '3. Yum!'], image_url: 'yummy pasta url', cook_time: 10, public_status: true, source_name: 'Italian Chef', source_url: 'Italian Chef Web')
        pasta = recipe_3.ingredients.create!(name: 'pasta', units: 1.0, unit_type: 'lbs')
        butter = recipe_3.ingredients.create!(name: 'butter', units: 2, unit_type: 'oz')
        

        expect(Recipe.all.count).to eq(1)
        expect(Ingredient.all.count).to eq(2)
        expect(RecipeIngredient.all.count).to eq(2)
  
        params = {ingredients: "butter,+pasta"}
        search = RecipeSearch.new(params)

        search.search
  
        expect(Recipe.all.count > 1).to be(true )
        
        expect(Recipe.last.name).to be_a(String)
        expect(Recipe.last.api_id).to be_a(String)
        expect(Recipe.last.image_url).to be_a(String)
      end
    end

    it "searches for Api only if there are < 10 local results" do 
      # VCR not needed here b/c local database results will be > 10. 
      # if VCR error occurs here then the conditional or search function has changed/broken.
      recipe_search_data_name
      recipe_search_data_ingredients

      params = {name: "gaRlic"}

      expect(RecipeSearch.new(params).search.count).to eq(12)
      
      params = {ingredients: "garlic,+tofu"}
      
      expect(RecipeSearch.new(params).search.count).to eq(12)
    end
  end
end