require 'rails_helper'

RSpec.describe SpoonSearch do
  describe 'instance methods' do
    it 'will add recipes to cache', :vcr do
      VCR.use_cassette("SpoonSearch/instance_methods/will_add_recipes_to_cache.yml", match_requests_on: [:path]) do 

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

    it 'will add detailed data to a recipe', :vcr do
      VCR.use_cassette("SpoonSearch/instance_methods/will_add_detailed_data_to_a_recipe.yml", match_requests_on: [:path]) do
        recipe = Recipe.create!(name: 'Beans', api_id: '1099404', image_url: 'sweeturl', user_submitted: false)

        SpoonSearch.new(api_id: recipe.api_id).recipe_by_id
        
        recipe.reload
        
        expect(recipe.instructions).to be_an(Array)
        expect(recipe.cook_time).to be_an(Integer)
        expect(recipe.source_name).to be_a(String)
        expect(recipe.source_url).to be_a(String)
      end
    end

    it 'will search by ingredients with detailed information', :vcr do
      VCR.use_cassette("SpoonSearch/instance_methods/will_search_by_ingredients_with_detailed_information.yml", match_requests_on: [:path]) do
      
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

    it 'will search for recipe results by name', :vcr do
      VCR.use_cassette('SpoonSearch/instance_methods/will_search_for_recipe_results_by_name.yml', match_requests_on: [:path]) do
        expect(Recipe.all.count).to eq(0)

        query = 'bruschetta stuffed'
        recipes = SpoonSearch.new(name: query).name_search
        
        expect(Recipe.all.count).to_not eq(0)
        expect(Recipe.first.name).to include('Bruschetta')
        expect(Recipe.first.api_id).to be_a(String)
        expect(Recipe.first.image_url).to be_a(String)
      end
    end
  end
end
