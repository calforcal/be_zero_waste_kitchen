require "rails_helper"

RSpec.describe "User API", type: :request do
  let!(:user) { User.create!(uid: '123') }
  before(:each) do
    @valid_params = { uid: user.uid }
    @invalid_valid_params = { uid: 0 }
    headers = { 'CONTENT_TYPE' => 'application/json' }
  end

  describe "DELETE /api/v1/user/:user_id" do
    it "can successfully delete a user" do
      delete "/api/v1/users/#{user.id}", headers: headers, params: @valid_params
      expect(response).to be_successful
    end

    it "cannot successfully delete a user if the id does not match" do
      delete "/api/v1/users/0", headers: headers, params: @invalid_valid_params
      expect(response).to_not be_successful
    end
  end
end