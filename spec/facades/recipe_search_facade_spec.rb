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
        expect(Recipe.all.count).to eq(0)
        expect(Ingredient.all.count).to eq(0)
        expect(RecipeIngredient.all.count).to eq(0)
  
        params = {ingredients: ["butter", "pasta"]}
        search = RecipeSearch.new(params)
        search.search
  
        expect(Recipe.all.count).to_not eq(0)
        
        expect(Recipe.first.name).to be_a(String)
        expect(Recipe.first.api_id).to be_a(String)
        expect(Recipe.first.image_url).to be_a(String)
      end
    end
  end
end