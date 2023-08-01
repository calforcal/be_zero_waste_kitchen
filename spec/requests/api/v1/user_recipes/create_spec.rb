require 'rails_helper'

describe 'UserRecipe API', type: :request do
  let!(:user_1) { User.create!(uid: '123') }
  let!(:recipe_1) { Recipe.create!(name: 'Bomb Sauce') }

  describe 'Cook/Rate/Save a Recipe' do
    describe 'happy paths' do
      it 'can save a recipe' do
        user_recipe_params = {
          uid: "123",
          recipe_id: 192,
          api_id: "string",
          saved_status: true
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }
        post "/api/v1/recipes/#{recipe_1.id}", headers: headers, params: JSON.generate(user_recipe_params)

        expect(response).to be_successful
        # expect(response.status).to eq(404)

        user_recipe = UserRecipe.last
     
        expect(user_recipe.saved_status).to be(true)
        expect(user_recipe.user_id).to eq(user_1.id)
        expect(user_recipe.recipe_id).to eq(recipe_1.id)
        expect(user_recipe.cook_status).to be(nil) 
        expect(user_recipe.num_stars).to eq(nil)
      end
      
      it 'can cook a recipe' do 
        user_recipe_params = {
          uid: "123",
          recipe_id: 192,
          api_id: "string",
          cook_status: true
        }
  
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post "/api/v1/recipes/#{recipe_1.id}", headers:, params: JSON.generate(user_recipe_params)
  
        user_recipe = UserRecipe.find_by(user_id: user_1.id, recipe_id: recipe_1.id)
  
        expect(user_recipe.saved_status).to be(nil)
        expect(user_recipe.user_id).to eq(user_1.id)
        expect(user_recipe.recipe_id).to eq(recipe_1.id)
        expect(user_recipe.cook_status).to be(true) 
        expect(user_recipe.num_stars).to eq(nil)
      end

      it 'can rate a recipe' do 
        user_recipe_params = {
          uid: "123",
          recipe_id: recipe_1.id,
          api_id: "string",
          num_stars: 4
        }
        user_recipe = UserRecipe.create!(user_id: user_1.id, recipe_id: recipe_1.id)

        headers = { 'CONTENT_TYPE' => 'application/json' }
        post "/api/v1/recipes/#{recipe_1.id}", headers:, params: JSON.generate(user_recipe_params)
  
        user_recipe.reload
  
        expect(user_recipe.saved_status).to be(nil)
        expect(user_recipe.user_id).to eq(user_1.id)
        expect(user_recipe.recipe_id).to eq(recipe_1.id)
        expect(user_recipe.cook_status).to be(nil) 
        expect(user_recipe.num_stars).to eq(4)
      end
    end
  end
end