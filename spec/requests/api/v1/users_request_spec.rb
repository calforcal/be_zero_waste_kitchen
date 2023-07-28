require "rails_helper"

describe "Users API" do
  let!(:user_1) { User.create!(uid: "123", name: "Michael C", email: "michael@gmail.com") }
  let!(:user_2) { User.create!(uid: "456", name: "Carolyn C", email: "carolyn@gmail.com") }

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
      end
    end
  end

  describe "Create One Merchant" do
    describe "happy paths" do
      it "can create one merchant" do
        user_params = ({
          uid: "000",
          name: "Busta Rhymes",
          email: "busta@gmail.com",
          token: "A3000"
        })

        headers = {"CONTENT_TYPE" => "application/json"}
        post api_v1_users_path, headers: headers, params: JSON.generate(user: user_params)
        created_user = User.last

        expect(created_user.uid).to eq(user_params[:uid])
        expect(created_user.name).to eq(user_params[:name])
        expect(created_user.email).to eq(user_params[:email])
      end
    end
  end
end