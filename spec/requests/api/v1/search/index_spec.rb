require "rails_helper" 

RSpec.describe "Recipes Search", type: :request do 
  describe "get recipes by ingredients" do 
    it "can get a list of recipes by ingredients" do
      eggplant_search = File.read('spec/fixtures/search_index_ingredients.json')
      stub_request(:get, "/api/v1/recipes/search?ingredients=eggplant")
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Faraday v2.7.9'
          }
        )
      .to_return(status: 200, body: eggplant_search, headers: {})
      get "/api/v1/recipes/search?ingredients=eggplant"

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)

      recipes = parsed[:data]

      expect(recipes[0][:id]).to be_a(String)
      expect(recipes[0][:type]).to eq("search")
      expect(recipes[0][:attributes]).to be_an(Hash)
      expect(recipes[0][:attributes][:name]).to be_a(String)
      expect(recipes[0][:attributes][:api_id]).to be_a(String)
    end
  end
end