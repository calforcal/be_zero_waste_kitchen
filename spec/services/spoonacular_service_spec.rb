require 'rails_helper'

RSpec.describe SpoonacularService do
  describe 'instance methods' do
    describe '#recipes_by_ingredients' do
      it 'gets all recipes based on list of ingredients', :vcr do
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
  end
end
