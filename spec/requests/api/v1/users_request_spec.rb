require 'rails_helper'

describe 'Users API' do
  let!(:user_1) { User.create!(uid: '123', name: 'Michael C', email: 'michael@gmail.com') }
  let!(:user_2) { User.create!(uid: '456', name: 'Carolyn C', email: 'carolyn@gmail.com') }

  let!(:recipe_1) { Recipe.create!(name: 'Chicken Parm', api_id: "123456789123456789", instructions: ['1. Cook the chicken', '2. Cover in sauce and cheese', '3. Enjoy!'], image_url: 'pic of my chicken parm', cook_time: 45, public_status: true, source_name: user_1.name, source_url: "/api/v1/users/#{user_1.id}") }
  let!(:chicken) { Ingredient.create!(name: 'Chicken', units: 2.0, unit_type: 'lbs') }
  let!(:cheese) { Ingredient.create!(name: 'Cheese', units: 0.5, unit_type: 'lbs') }
  let!(:recipe_ingredients_1) { recipe_1.recipe_ingredients.create!(ingredient_id: chicken.id) }
  let!(:recipe_ingredients_2) { recipe_1.recipe_ingredients.create!(ingredient_id: cheese.id) }

  let!(:recipe_2) { Recipe.create!(name: 'Meatballs', api_id: "1234567891234567891", instructions: ['1. Cook the meatballs', '2. Cover in sauce', '3. Eat!'], image_url: 'meatballs path', cook_time: 22, public_status: true, source_name: 'Italian Chef', source_url: 'Italian Chef Web') }
  let!(:ground_beef) { Ingredient.create!(name: 'ground beef', units: 2.0, unit_type: 'lbs') }
  let!(:eggs) { Ingredient.create!(name: 'eggs', units: 2.0, unit_type: 'oz') }
  let!(:recipe_ingredients_3) { recipe_1.recipe_ingredients.create!(ingredient_id: ground_beef.id) }
  let!(:recipe_ingredients_4) { recipe_1.recipe_ingredients.create!(ingredient_id: eggs.id) }

  let!(:user_recipe_1) { user_1.user_recipes.create!(recipe_id: recipe_1.id, num_stars: 4, cook_status: false, saved_status: true, is_owner: true) }
  let!(:user_recipe_2) { user_1.user_recipes.create!(recipe_id: recipe_2.id, num_stars: 5, cook_status: true, saved_status: true, is_owner: false) }

  let!(:saved_ingredient_1) { user_1.saved_ingredients.create!(ingredient_name: chicken.name, unit_type: chicken.unit_type, units: chicken.units)}
  let!(:saved_ingredient_2) { user_1.saved_ingredients.create!(ingredient_name: cheese.name, unit_type: cheese.unit_type, units: cheese.units)}
  let!(:saved_ingredient_3) { user_1.saved_ingredients.create!(ingredient_name: ground_beef.name, unit_type: ground_beef.unit_type, units: ground_beef.units)}
  let!(:saved_ingredient_4) { user_1.saved_ingredients.create!(ingredient_name: eggs.name, unit_type: eggs.unit_type, units: eggs.units)}

  describe 'Fetch One Merchant' do
    describe 'happy paths' do
      it 'can get one merchant', :vcr do
        get api_v1_user_path(user_1)

        expect(response).to be_successful

        parsed = JSON.parse(response.body, symbolize_names: true)

        user = parsed[:data]

        expect(user).to have_key(:id)
        expect(user[:id]).to be_a(String)

        expect(user[:attributes]).to have_key(:uid)
        expect(user[:attributes][:uid]).to be_a(String)

        expect(user[:attributes]).to have_key(:name)
        expect(user[:attributes][:name]).to be_a(String)

        expect(user[:attributes]).to have_key(:email)
        expect(user[:attributes][:email]).to be_a(String)

        expect(user[:attributes]).to have_key(:stats)
        expect(user[:attributes][:stats]).to be_a Hash

        stats = user[:attributes][:stats]

        expect(stats).to have_key(:recipes_created)
        expect(stats[:recipes_created]).to be_an Integer

        expect(stats).to have_key(:recipes_cooked)
        expect(stats[:recipes_cooked]).to be_an Integer

        expect(stats).to have_key(:kg_emissions_saved)
        expect(stats[:kg_emissions_saved]).to be_an Float
      end

      it 'can get one merchants cooked recipes', :vcr do
        get api_v1_user_path(user_1)

        expect(response).to be_successful

        parsed = JSON.parse(response.body, symbolize_names: true)

        user = parsed[:data]
        user_cooked_recipes = user[:attributes]

        expect(user_cooked_recipes).to have_key(:cooked_recipes)
        expect(user_cooked_recipes[:cooked_recipes]).to be_an Array
        expect(user_cooked_recipes[:cooked_recipes].first).to be_an Hash

        first_recipe = user_cooked_recipes[:cooked_recipes].first

        expect(first_recipe).to have_key(:id)
        expect(first_recipe[:id]).to be_an Integer

        expect(first_recipe).to have_key(:name)
        expect(first_recipe[:name]).to be_a String

        expect(first_recipe).to have_key(:api_id)
        expect(first_recipe[:api_id]).to be_a String
      end

      it 'can get one merchants created recipes', :vcr do
        get api_v1_user_path(user_1)

        expect(response).to be_successful

        parsed = JSON.parse(response.body, symbolize_names: true)

        user = parsed[:data]
        user_created_recipes = user[:attributes]

        expect(user_created_recipes).to have_key(:created_recipes)
        expect(user_created_recipes[:created_recipes]).to be_an Array
        expect(user_created_recipes[:created_recipes].first).to be_an Hash

        first_recipe = user_created_recipes[:created_recipes].first

        expect(first_recipe).to have_key(:id)
        expect(first_recipe[:id]).to be_an Integer

        expect(first_recipe).to have_key(:name)
        expect(first_recipe[:name]).to be_a String

        expect(first_recipe).to have_key(:api_id)
        expect(first_recipe[:api_id]).to be_a String
      end

      it 'can get the Number of one merchants cooked recipes', :vcr do
        get api_v1_user_path(user_1)

        expect(response).to be_successful

        parsed = JSON.parse(response.body, symbolize_names: true)

        user = parsed[:data]
        user_cooked_recipes = user[:attributes]

        expect(user_cooked_recipes).to have_key(:num_cooked_recipes)
        expect(user_cooked_recipes[:num_cooked_recipes]).to be_an Integer
      end

      it 'can get the Number of one merchants created recipes', :vcr do
        get api_v1_user_path(user_1)

        expect(response).to be_successful

        parsed = JSON.parse(response.body, symbolize_names: true)

        user = parsed[:data]
        user_created_recipes = user[:attributes]

        expect(user_created_recipes).to have_key(:num_created_recipes)
        expect(user_created_recipes[:num_created_recipes]).to be_an Integer
      end
    end
  end

  describe "Create One Merchant" do
    describe "happy paths" do
      it "can create one merchant", :vcr do
        user_params = ({
          uid: "000",
          name: "Busta Rhymes",
          email: "busta@gmail.com"
        })

        headers = { 'CONTENT_TYPE' => 'application/json' }
        post api_v1_users_path, headers:, params: JSON.generate(user: user_params)
        created_user = User.last

        expect(created_user.uid).to eq(user_params[:uid])
        expect(created_user.name).to eq(user_params[:name])
        expect(created_user.email).to eq(user_params[:email])
      end
    end
  end
end
