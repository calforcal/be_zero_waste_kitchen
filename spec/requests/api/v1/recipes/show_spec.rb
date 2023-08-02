require 'rails_helper'

describe 'Recipe API' do
  let!(:user_1) { User.create!(uid: '123') }
  let!(:recipe_1) { FactoryBot.create(:recipe) }
  let!(:user_recipe) { UserRecipe.create!(user: user_1, recipe: recipe_1) }
  let!(:ingredient_1) { Ingredient.create!(name: 'Banana', units: 2, unit_type: "cups") }
  let!(:ingredient_2) { Ingredient.create!(name: 'Cream', units: 1, unit_type: "cups") }
  let!(:recipe_ingredient_1) { RecipeIngredient.create!(recipe: recipe_1, ingredient: ingredient_1) }
  let!(:recipe_ingredient_2) { RecipeIngredient.create!(recipe: recipe_1, ingredient: ingredient_2) }


  describe 'Create One Recipe' do
    describe 'happy paths' do
      it 'can fetch one recipe' do
        get api_v1_recipe_path(recipe_1)
        
        expect(response).to be_successful
        expect(response.status).to eq(200)
        
        recipe = JSON.parse(response.body, symbolize_names: true)
        expect(recipe).to be_a(Hash)
        expect(recipe).to have_key(:data)
        expect(recipe[:data]).to be_a(Hash)

        data = recipe[:data]

        expect(data).to have_key(:id)
        expect(data[:id]).to be_a(String)

        expect(data).to have_key(:type)
        expect(data[:type]).to be_a(String)
        expect(data[:type]).to eq('recipe')
        expect(data).to have_key(:attributes)
        expect(data[:attributes]).to be_a(Hash)
        
        attributes = data[:attributes]
        
        expect(attributes).to have_key(:name)
        expect(attributes[:name]).to be_a(String)
        expect(attributes[:name]).to eq("Banana Foster")

        expect(attributes).to have_key(:ingredients)
        expect(attributes[:ingredients]).to be_an(Array)
        expect(attributes[:ingredients][0]).to be_a(Hash)

        first_ingredient = attributes[:ingredients][0]
        expect(first_ingredient).to have_key(:id)
        expect(first_ingredient[:id]).to eq(ingredient_1.id)

        first_ingredient = attributes[:ingredients][0]
        expect(first_ingredient).to have_key(:name)
        expect(first_ingredient[:name]).to eq(ingredient_1.name)

        first_ingredient = attributes[:ingredients][0]
        expect(first_ingredient).to have_key(:name)
        expect(first_ingredient[:name]).to eq(ingredient_1.name)

        first_ingredient = attributes[:ingredients][0]
        expect(first_ingredient).to have_key(:units)
        expect(first_ingredient[:units]).to eq(ingredient_1.units)

        first_ingredient = attributes[:ingredients][0]
        expect(first_ingredient).to have_key(:unit_type)
        expect(first_ingredient[:unit_type]).to eq(ingredient_1.unit_type)

        expect(attributes).to have_key(:image_url)
        expect(attributes[:image_url]).to be_a(String)
        expect(attributes[:image_url]).to eq(recipe_1.image_url)

        expect(attributes).to have_key(:instructions)
        expect(attributes[:instructions]).to be_an(Array)
        expect(attributes[:instructions]).to eq(recipe_1.instructions)

        expect(attributes[:instructions].first).to be_a(String)
        expect(attributes[:instructions].first).to eq("1. Eat")

        expect(attributes[:instructions].last).to be_a(String)
        expect(attributes[:instructions].last).to eq("2. Enjoy")

        expect(attributes).to have_key(:cook_time)
        expect(attributes[:cook_time]).to be_a(Integer)
        expect(attributes[:cook_time]).to eq(recipe_1.cook_time)

        expect(attributes).to have_key(:public_status)
        expect(attributes[:public_status]).to be_a(TrueClass)
        expect(attributes[:public_status]).to eq(recipe_1.public_status)

        expect(attributes).to have_key(:source_name)
        expect(attributes[:source_name]).to be_a(String)
        expect(attributes[:source_name]).to eq(recipe_1.source_name)

        expect(attributes).to have_key(:source_url)
        expect(attributes[:source_url]).to be_a(String)
        expect(attributes[:source_url]).to eq(recipe_1.source_url)

        expect(attributes).to have_key(:user_submitted)
        expect(attributes[:user_submitted]).to be_a(NilClass)
        expect(attributes[:user_submitted]).to eq(recipe_1.user_submitted)
        
        expect(attributes).to have_key(:api_id)
        expect(attributes[:api_id]).to be_a(NilClass)
        expect(attributes[:api_id]).to eq(recipe_1.api_id)
      end
    end
  
    describe 'sad path' do
      it "rejects request if the merchant does not exists" do
        recipe_id = 1902933094309327094537
        get api_v1_recipe_path(recipe_id)
    
        expect(response).to_not be_successful
        expect(response.status).to eq(404)
        expect{Recipe.find(recipe_id)}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end