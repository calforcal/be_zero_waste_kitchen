require "rails_helper"

RSpec.describe "User API", type: :request do
  let!(:user) { User.create!(uid: '123') }
  let!(:recipe) { Recipe.create!(name: 'Bomb Sauce') }
  before(:each) do
    @user_recipe = UserRecipe.create!(user_id: user.id, recipe_id: recipe.id)
    @valid_params = { uid: user.uid, recipe_id: recipe.id }
    @invalid_valid_params1 = { uid: 0, recipe_id: recipe.id }
    @invalid_valid_params2 = { uid: 0, recipe_id: recipe.id }
    headers = { 'CONTENT_TYPE' => 'application/json' }
  end

  describe "DELETE /api/v1/user/:user_id/recipes/:recipe_id" do
    it "can successfully delete a recipe" do
      delete "/api/v1/user/#{user.id}/recipes/#{recipe.id}", headers: headers, params: @valid_params
      expect(response).to be_successful
    end

    it "cannot successfully delete a recipe if the user id does not match" do
      delete "/api/v1/user/#{user.id}/recipes/#{recipe.id}", headers: headers, params: @invalid_valid_params1
      expect(response).to_not be_successful
    end

    it "cannot successfully delete a recipe if the recipe id does not match" do
      delete "/api/v1/user/#{user.id}/recipes/#{recipe.id}", headers: headers, params: @invalid_valid_params2
      expect(response).to_not be_successful
    end
  end
end