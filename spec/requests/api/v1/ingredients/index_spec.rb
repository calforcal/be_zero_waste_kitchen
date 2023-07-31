require 'rails_helper'

describe 'Ingredients External API Search' do
  describe 'get ingredients by query' do
    it 'can get a list of ingredients' do
      query = 'grapes'

      get api_v1_ingredients_path(query: "grapes")

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)

      ingredients = parsed[:data]

      ingredients.each do |ingredient|
        expect(ingredient[:attributes]).to be_a Hash
        expect(ingredient[:attributes]).to have_key(:name)
        expect(ingredient[:attributes][:name]).to be_a String
      end
    end
  end
end