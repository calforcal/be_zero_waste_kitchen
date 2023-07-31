require 'rails_helper'

RSpec.describe UserRecipe, type: :model do
  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :recipe }
  end

  describe 'validations' do
    it { should validate_numericality_of :num_stars }
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
      association = UserRecipe.create_user_recipe(params)
      expect(rating.num_stars).to be nil
      
      params1 = {
        uid: "5e",
        recipe_id: @recipe1.id
        api_id: "674"
        cook_status: true
      }
      
      association = UserRecipe.create_user_recipe(params)
      expect(rating.cook_status).to be(true)
      
      params2 = {
        uid: "5e",
        recipe_id: @recipe1.id, 
        api_id: "9838",
        num_stars: 4
      }

      association = UserRecipe.create_user_recipe(params)
      expect(rating.num_stars).to eq(4)

      params3 = {
        uid: "7a",
        recipe_id: @recipe1.id
        api_id: "674"
        saved_status: true
      }

      rating = UserRecipe.create_user_recipe(params)
      expect(rating.cook_status).to be(true)
    end
  end
end
