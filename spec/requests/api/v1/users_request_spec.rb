require "rails_helper"

describe "Users API" do
  let!(:user_1) { User.create!(uid: "123", name: "Michael C", email: "michael@gmail.com", token: "ABC123") }
  let!(:user_2) { User.create!(uid: "456", name: "Carolyn C", email: "carolyn@gmail.com", token: "DEF456") }

  describe "Fetch One Merchant" do
    describe "happy paths" do
      it "can get one merchant" do
        get api_v1_user_path(user_1)

        expect(response).to be_successful

        parsed = JSON.parse(response.body, symbolize_names: true)

        user = parsed[:data]

        expect(user).to have_key(:id)
        expect(user[:id]).to be_a(String)

        expect(user[:attributes]).to have_key(:uid)
        expect(user[:attributes][:uid]).to be_a(String)

        expect(user[:attributes]).to have_key(:name)
        expect(user[:attributes][:name]).to be_a(String)

        expect(user[:attributes]).to have_key(:email)
        expect(user[:attributes][:email]).to be_a(String)

        expect(user[:attributes]).to have_key(:token)
        expect(user[:attributes][:token]).to be_a(String)
      end
    end
  end
end