require 'rails_helper'

describe 'Users API' do
  describe 'find_or_create_user' do
    it 'can find a User', :vcr do
      already_exists = User.create(uid: '1234567890987654321')

      get api_v1_user_path('1234567890987654321')

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)

      user = parsed[:data]

      expect(user).to have_key(:id)
      expect(user[:id]).to be_a(String)

      expect(user[:attributes]).to have_key(:uid)
      expect(user[:attributes][:uid]).to be_a(String)


      expect(user[:attributes]).to have_key(:stats)
      expect(user[:attributes][:stats]).to be_a Hash

      stats = user[:attributes][:stats]

      expect(stats).to have_key(:recipes_created)
      expect(stats[:recipes_created]).to be_an Integer

      expect(stats).to have_key(:recipes_cooked)
      expect(stats[:recipes_cooked]).to be_an Integer

      expect(stats).to have_key(:kg_emissions_saved)
      expect(stats[:kg_emissions_saved]).to be_an Float
    end

    it 'can create a user if its not found', :vcr do
      get api_v1_user_path('abcdefghijklmnopqrstuvwxyz123456789')

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)

      user = parsed[:data]

      expect(user).to have_key(:id)
      expect(user[:id]).to be_a(String)

      expect(user[:attributes]).to have_key(:uid)
      expect(user[:attributes][:uid]).to be_a(String)


      expect(user[:attributes]).to have_key(:stats)
      expect(user[:attributes][:stats]).to be_a Hash

      stats = user[:attributes][:stats]

      expect(stats).to have_key(:recipes_created)
      expect(stats[:recipes_created]).to be_an Integer

      expect(stats).to have_key(:recipes_cooked)
      expect(stats[:recipes_cooked]).to be_an Integer

      expect(stats).to have_key(:kg_emissions_saved)
      expect(stats[:kg_emissions_saved]).to be_an Float
    end
  end
end