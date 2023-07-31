require 'rails_helper'

describe 'Recipe API' do

  let!(:user_1) { User.create!(uid: '123') }

  describe 'Create One Recipe' do
    describe 'happy paths' do
      it 'can create one merchant' do
        recipe_params = ({
          name: 'Dope Salad',
          instructions: "1. Rinse spinach and lettuce, 2. Get out that dressing give it a shake, 3. Add chickpeas and tomatoes and strawberries, 4. Shake it off yeah yeah shake it off",
          cook_time: 10,
          public_status: true,
          source_name: user_1.uid,
          source_url: api_v1_user_path(user_1),
          user_submitted: true
        })

        headers = {"CONTENT_TYPE" => "application/json"}
        post api_v1_recipes_path, headers: headers, params: JSON.generate(recipe: recipe_params)

        created_recipe = Recipe.last

        expect(created_recipe.name).to eq(recipe_params[:name])
        expect(created_recipe.instructions).to eq(['1. Rinse spinach and lettuce', '2. Get out that dressing give it a shake', '3. Add chickpeas and tomatoes and strawberries', '4. Shake it off yeah yeah shake it off'])
        expect(created_recipe.cook_time).to eq(recipe_params[:cook_time])
        expect(created_recipe.public_status).to eq(recipe_params[:public_status])
        expect(created_recipe.source_name).to eq(recipe_params[:source_name])
        expect(created_recipe.source_url).to eq(recipe_params[:source_url])
        expect(created_recipe.user_submitted).to eq(recipe_params[:user_submitted])
      end

      it 'can create ingredients and recipe_ingredients during recipe creation' do
        recipe_params = ({
          name: 'Dope Salad',
          instructions: "1. Rinse spinach and lettuce,2. Get out that dressing give it a shake, 3. Add chickpeas and tomatoes and strawberries, 4. Shake it off yeah yeah shake it off",
          cook_time: 10,
          public_status: true,
          source_name: user_1.uid,
          source_url: api_v1_user_path(user_1),
          user_submitted: true
        })

        ingredients_params = ([
          {
            name: 'Spinach',
            units: 1.0,
            unit_type: 'cups'
          },
          {
            name: 'Lettuce',
            units: 1.0,
            unit_type: 'cups'
          },
          {
            name: 'Vegan Ranch',
            units: 0.5,
            unit_type: 'cups'
          },
          {
            name: 'Chickpeas',
            units: 0.5,
            unit_type: 'cups'
          },
          {
            name: 'Cherry Tomatoes',
            units: 0.5,
            unit_type: 'cups'
          },
          {
            name: 'Strawberries',
            units: 0.25,
            unit_type: 'cups'
          }
        ])

        headers = {"CONTENT_TYPE" => "application/json"}
        post api_v1_recipes_path, headers: headers, params: JSON.generate(recipe: recipe_params, ingredients: ingredients_params)

        created_recipe = Recipe.last
        first_ingredient = created_recipe.ingredients.first

        expect(created_recipe.ingredients.count).to eq(6)

        expect(first_ingredient.name).to eq(ingredients_params.first[:name])
        expect(first_ingredient.units).to eq(ingredients_params.first[:units])
        expect(first_ingredient.unit_type).to eq(ingredients_params.first[:unit_type])
      end
    end

    describe 'sad paths' do
      it 'will not create a recipe without name or public_status' do
        recipe_params = ({
          instructions: "1. Rinse spinach and lettuce, 2. Get out that dressing give it a shake, 3. Add chickpeas and tomatoes and strawberries, 4. Shake it off yeah yeah shake it off",
          cook_time: 10,
          public_status: true,
          source_name: user_1.uid,
          source_url: api_v1_user_path(user_1),
          user_submitted: true
        })

        headers = {"CONTENT_TYPE" => "application/json"}
        post api_v1_recipes_path, headers: headers, params: JSON.generate(recipe: recipe_params)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors]).to be_a(Array)
        expect(data[:errors].first[:status]).to eq('404')
        expect(data[:errors].first[:title]).to eq("Validation failed: Name can't be blank")
      end
    end
  end
end