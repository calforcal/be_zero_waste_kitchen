require 'rails_helper'

RSpec.describe IngredientsFacade do
  describe 'Ingredients' do
    describe '#ingredients_list' do
      it 'can produce a list of ingredients based on search', :vcr do
        query = 'grape'
        data = IngredientsFacade.new(query).ingredients_list

        expect(data).to be_an Array

        data.each do |ingredient|
          expect(ingredient.name).to be_a String
        end

        expect(data.first.name).to eq('grape')
      end
    end
  end
end