require 'rails_helper'

describe 'Recipe API' do
  let!(:user_1) { User.create!(uid: '123') }
  let!(:recipe_1) { Recipe.create!(
                                  name: 'Salad', 
                                  instructions: ",1. Eat it!,",
                                  image_url: "www.image.com",
                                  cook_time: 5, 
                                  public_status: true,
                                  source_name: "Chef Mike",
                                  source_url: "www.chefmike.com",
                                  user_submitted: true
                                  ) 
                  }

  describe 'PUT api_v1_recipe_path' do
    describe 'happy paths' do
      it 'can update one recipe' do
        id = recipe_1.id
        created_recipe = Recipe.last

        recipe_params = {
          name: 'Dope Salad',
          instructions: ",1. Rinse spinach and lettuce, 2. Get out that dressing give it a shake, 3. Add chickpeas and tomatoes and strawberries, 4. Shake it off yeah yeah shake it off,",
          cook_time: 10,
          public_status: true,
          source_name: "Chef Mateo",
          source_url: "www.chefmateo.com",
          user_submitted: false
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }
        put api_v1_recipe_path(recipe_1), headers:, params: JSON.generate(recipe: recipe_params)

        updated_recipe = Recipe.last

        expect(response).to be_successful

        expect(updated_recipe.id).to eq(created_recipe.id)
        expect(updated_recipe.public_status).to eq(created_recipe.public_status)

        expect(updated_recipe.name).to_not eq(created_recipe.name)
        expect(updated_recipe.name).to eq("Dope Salad")

        expect(updated_recipe.instructions).to_not eq(created_recipe.instructions)
        expect(updated_recipe.instructions).to eq(["1. Rinse spinach and lettuce", " 2. Get out that dressing give it a shake", " 3. Add chickpeas and tomatoes and strawberries", " 4. Shake it off yeah yeah shake it off"])

        expect(updated_recipe.cook_time).to_not eq(created_recipe.cook_time)
        expect(updated_recipe.cook_time).to eq(10)

        expect(updated_recipe.source_name).to_not eq(created_recipe.source_name)
        expect(updated_recipe.source_name).to eq("Chef Mateo")

        expect(updated_recipe.source_url).to_not eq(created_recipe.source_url)
        expect(updated_recipe.source_url).to eq("www.chefmateo.com")

        expect(updated_recipe.user_submitted).to_not eq(created_recipe.user_submitted)
        expect(updated_recipe.user_submitted).to be(false)
      end

      it 'can update ingredients and recipe_ingredients during recipe update' do
        recipe_params = {
          name: 'Dope Salad',
          instructions: '1. Rinse spinach and lettuce,2. Get out that dressing give it a shake, 3. Add chickpeas and tomatoes and strawberries, 4. Shake it off yeah yeah shake it off',
          cook_time: 10,
          public_status: true,
          source_name: "Chef Mike",
          source_url: "www.chefmike.com",
          user_submitted: true
        }

        ingredients_params = [
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
        ]

        headers = { 'CONTENT_TYPE' => 'application/json' }
        post api_v1_recipes_path, headers:,
                                  params: JSON.generate(recipe: recipe_params, ingredients: ingredients_params)

        created_recipe = Recipe.last
        id = created_recipe.id

        update_recipe_params = {
          name: 'Dope Salad',
          instructions: ",1. Rinse spinach and lettuce, 2. Get out that dressing give it a shake, 3. Add chickpeas and tomatoes and strawberries, 4. Shake it off yeah yeah shake it off,",
          cook_time: 10,
          public_status: true,
          source_name: "Chef Mateo",
          source_url: "www.chefmateo.com",
          user_submitted: false
        }

        update_ingredients_params = [
          {
            name: 'Cabbage',
            units: 2.0,
            unit_type: 'cups'
          },
          {
            name: 'Tomatoes',
            units: 1.0,
            unit_type: 'cups'
          }
        ]

        put api_v1_recipe_path(created_recipe), headers:, params: JSON.generate(recipe: update_recipe_params, ingredients: update_ingredients_params)


        updated_recipe = Recipe.last
        first_ingredient = updated_recipe.ingredients.first
        last_ingredient = updated_recipe.ingredients.last
        # require 'pry'; binding.pry
        expect(updated_recipe.ingredients.count).to eq(2)

        expect(first_ingredient.name).to eq(update_ingredients_params.first[:name])
        # expect(first_ingredient.units).to eq(ingredients_params.first[:units])
        # expect(first_ingredient.unit_type).to eq(ingredients_params.first[:unit_type])
      end
    end

    # describe 'sad paths' do
    #   it 'will not update a recipe without a name' do
    #     recipe_params = {
    #       instructions: '1. Rinse spinach and lettuce, 2. Get out that dressing give it a shake, 3. Add chickpeas and tomatoes and strawberries, 4. Shake it off yeah yeah shake it off',
    #       cook_time: 10,
    #       public_status: true,
    #       source_name: user_1.uid,
    #       source_url: api_v1_user_path(user_1),
    #       user_submitted: true
    #     }

    #     headers = { 'CONTENT_TYPE' => 'application/json' }
    #     post api_v1_recipes_path, headers:, params: JSON.generate(recipe: recipe_params)

    #     expect(response).to_not be_successful
    #     expect(response.status).to eq(404)

    #     data = JSON.parse(response.body, symbolize_names: true)

    #     expect(data[:errors]).to be_a(Array)
    #     expect(data[:errors].first[:status]).to eq('404')
    #     expect(data[:errors].first[:title]).to eq("Validation failed: Name can't be blank")
    #   end
    # end
  end
end