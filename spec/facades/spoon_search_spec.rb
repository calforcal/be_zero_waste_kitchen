require 'rails_helper'

RSpec.describe SpoonSearch do
  describe 'instance methods' do
    it 'will add recipes to cache' do
      VCR.use_cassette("SpoonSearch/instance_methods/will_add_recipes_to_cache", match_requests_on: [:path]) do 

        expect(Recipe.all.count).to eq(0)
        expect(Ingredient.all.count).to eq(0)
        expect(RecipeIngredient.all.count).to eq(0)

        query = %w[potatoes onions]
        SpoonSearch.new(ingredients: query).ingredient_search
        
        expect(Recipe.all.count).to_not eq(0)
        expect(Ingredient.all.count).to_not eq(0)
        expect(RecipeIngredient.all.count).to_not eq(0)
        
        expect(Recipe.first.name).to be_a(String)
        expect(Recipe.first.api_id).to be_a(String)
        expect(Recipe.first.image_url).to be_a(String)
        expect(Ingredient.first.name).to be_a(String)
        expect(Ingredient.first.units).to be_a(Float)
      end
    end

    it 'will add detailed data to a recipe' do
      VCR.use_cassette("SpoonSearch/instance_methods/will_add_detailed_data_to_a_recipe", match_requests_on: [:path]) do
        recipe = Recipe.create!(name: 'Beans', api_id: '1099404', image_url: 'sweeturl', user_submitted: false)

        SpoonSearch.new(api_id: recipe.api_id).recipe_by_id_ingredients_results
        
        recipe.reload
        
        expect(recipe.instructions).to be_an(Array)
        expect(recipe.cook_time).to be_an(Integer)
        expect(recipe.source_name).to be_a(String)
        expect(recipe.source_url).to be_a(String)
      end
    end

    it 'will search by ingredients with detailed information' do
      VCR.use_cassette("SpoonSearch/instance_methods/will_search_by_ingredients_with_detailed_information", match_requests_on: [:path]) do
      
        expect(Recipe.all.count).to eq(0)
        expect(Ingredient.all.count).to eq(0)
        expect(RecipeIngredient.all.count).to eq(0)

        query = %w[potatoes onions]
        SpoonSearch.new(ingredients: query).ingredient_search_details
        
        expect(Recipe.all.count).to_not eq(0)
        expect(Ingredient.all.count).to_not eq(0)
        expect(RecipeIngredient.all.count).to_not eq(0)
        
        expect(Recipe.first.name).to be_a(String)
        expect(Recipe.first.api_id).to be_a(String)
        expect(Recipe.first.image_url).to be_a(String)
        expect(Ingredient.first.name).to be_a(String)
        expect(Ingredient.first.units).to be_a(Float)
      end
    end

    it 'will search for recipe results by name'  do
      VCR.use_cassette('SpoonSearch/instance_methods/will_search_for_recipe_results_by_name', match_requests_on: [:path]) do
        expect(Recipe.all.count).to eq(0)

        query = 'bruschetta stuffed'
        recipes = SpoonSearch.new(name: query).name_search
        
        expect(Recipe.all.count).to_not eq(0)
        expect(Recipe.first.name).to include('Bruschetta')
        expect(Recipe.first.api_id).to be_a(String)
        expect(Recipe.first.image_url).to be_a(String)
      end
    end

    it 'will add details to recipes from name results' do 
      recipe1 = Recipe.create!(name: "Potato Wedges", api_id: "1099404", image_url: "here is picture", user_submitted: false)
      recipe1 = Recipe.create!(name: "Knishes", api_id: "648983", image_url: "here is picture", user_submitted: false)
      recipe1 = Recipe.create!(name: "Potato Salad", api_id: "653611", image_url: "here is picture", user_submitted: false)
      recipe1 = Recipe.create!(name: "Minestrone", api_id: "1234", image_url: "here is picture", user_submitted: false)
      VCR.use_cassette('SpoonSearch/instance_methods/will add details to recipes from name results', match_requests_on: [:path]) do 
        
        
      end
    end
  end
end
