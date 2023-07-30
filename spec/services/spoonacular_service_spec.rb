require 'rails_helper'

RSpec.describe SpoonacularService do
  describe 'instance methods' do
    describe '#recipes_by_ingredients' do
      it 'gets all recipes based on list of ingredients', :vcr do
        VCR.use_cassette(
          'SpoonacularService/instance_methods/_recipes_by_ingredients/gets_all_recipes_based_on_list_of_ingredients.yml', match_requests_on: [:path]
        ) do
          query = ['salt, potatoes']
          search = SpoonacularService.new.recipes_by_ingredients(query)

          expect(search).to be_an(Array)

          recipe = search.first

          expect(recipe).to have_key(:usedIngredientCount)
          expect(recipe).to have_key(:usedIngredients)
          expect(recipe[:usedIngredients]).to be_an(Array)
          expect(recipe[:usedIngredients].first).to have_key(:name)
          expect(recipe[:usedIngredients].first).to have_key(:amount)
          expect(recipe[:usedIngredients].first).to have_key(:unitShort)
        end
      end

      it 'gets a list of recipes from a basic query/name', :vcr do
        VCR.use_cassette(
          'SpoonacularService/instance_methods/_recipes_by_ingredients/gets_a_list_of_recipes_from_a_basic_query/name.yml', match_requests_on: [:path]
        ) do
          query = 'bruschetta stuffed'
          search = SpoonacularService.new.recipes_by_name(query)

          expect(search[:results]).to be_an(Array)

          recipe = search[:results].first

          expect(recipe[:title]).to be_a(String)
          expect(recipe[:id]).to be_an(Integer)
          expect(recipe[:image]).to be_a(String)
          expect(search[:totalResults]).to be_an(Integer)
        end
      end
    end
  end
end
