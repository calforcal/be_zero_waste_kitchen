require 'rails_helper'

RSpec.describe UserRecipe, type: :model do
  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :recipe }
  end

  describe "class methods" do 
    before(:each) do 
      @recipe1 = Recipe.create!(name: 'Spaghetti with Marinara')
      @user = User.create!(uid: "5e")
    end
    it "create_user_recipe" do 
      params2 = {
        uid: "5e",
        recipe_id: @recipe1.id, 
        api_id: "9838",
        num_stars: 4
      }
      # users cannot rate a recipe until they've cooked it.
      UserRecipe.create_user_recipe(params2)
      association = UserRecipe.find_by(user_id: @user.id, recipe_id: @recipe1.id)
      expect(association.num_stars).to be nil
      
      params1 = {
        uid: "5e",
        recipe_id: @recipe1.id,
        api_id: "674",
        cook_status: true
      }
    
      UserRecipe.create_user_recipe(params1)
      association.reload
      expect(association.cook_status).to be(true)
      
      params3 = {
        uid: "5e",
        recipe_id: @recipe1.id, 
        api_id: "9838",
        num_stars: 4
      }

    UserRecipe.create_user_recipe(params3)
      association.reload
      expect(association.num_stars).to eq(4)

      params4 = {
        uid: "5e",
        recipe_id: @recipe1.id,
        api_id: "674",
        saved_status: true
      }

      UserRecipe.create_user_recipe(params4)
      expect(association.cook_status).to be(true)
    end
  end
end
