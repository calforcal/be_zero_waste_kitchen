require 'rails_helper'

describe IngredientsService do
  describe 'ingredients_index' do
    it 'can take in a query and return an array of results', :vcr do
      query = 'grape'
      search = IngredientsService.new.ingredients_index(query)[:common]

      expect(search).to be_an Array
      expect(search.first).to be_a Hash

      search.each do |result|
        expect(result).to have_key(:food_name)
        expect(result[:food_name]).to be_a String
      end
    end
  end
end