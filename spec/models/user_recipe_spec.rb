require 'rails_helper'

RSpec.describe UserRecipe, type: :model do
  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :recipe }
  end

  describe "class methods" do 
    before(:each) do 
      @recipe1 = Recipe.create!(name: 'Spaghetti with Marinara')
      @user = User.create!(uid: "5e")
    end
  end
end
