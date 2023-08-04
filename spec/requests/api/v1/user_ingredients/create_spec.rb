require 'rails_helper'

RSpec.describe "User Ingredients API", type: :request do
  describe 'POST #create' do
    let!(:user_1) { User.create!(uid: '123') }

    let(:valid_params) do
      {
        uid: "#{user_1.uid}",
        ingredients: [
          {
            ingredient_name: 'Flour',
            units: 2.5,
            unit_type: 'cups'
          },
          {
            ingredient_name: 'Sugar',
            units: 1,
            unit_type: 'cup'
          }
        ]
      }
    end

    let(:invalid_params) do
      {
          ingredients: [
            {
              ingredient_name: 'Flour',
              units: 2.5,
              unit_type: 'cups'
            }
          ]
        }
    end

    it 'creates saved ingredients for the user' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post "/api/v1/users/#{user_1.id}/ingredients", headers: headers, params: JSON.generate(valid_params)
      expect(response).to be_successful

      expect(user_1.saved_ingredients.pluck(:ingredient_name)).to include("Flour", "Sugar")
    end

    it 'does not create saved ingredients and returns unprocessable_entity status' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post "/api/v1/users/#{user_1.id}/ingredients", headers: headers, params: JSON.generate(invalid_params)
      expect(response).to_not be_successful
    end

    context 'when user does not exist' do
      it 'returns not_found status' do
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post "/api/v1/users/#{user_1.id}/ingredients", headers: headers, params: JSON.generate(invalid_params)
        expect(response).to_not be_successful
      end
    end
  end
end
