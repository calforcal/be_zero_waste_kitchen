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
end