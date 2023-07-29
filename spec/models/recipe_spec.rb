require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :public_status }
  end

  describe 'associations' do
    it { should have_many :user_recipes }
    it { should have_many(:users).through(:user_recipes) }
    it { should have_many :recipe_ingredients }
    it { should have_many(:ingredients).through(:recipe_ingredients) }
  end

  describe "class methods" do
    before(:each) do 
      recipe1 = Recipe.create!(name: "Spaghetti with Marinara", ingredients: ["spaghetti", "sauce"])
      recipe2 = Recipe.create!(name: "Vegan Nachos", ingredients: ["chips", "vegan cheese sauce", "salsa"])
      recipe3 = Recipe.create!(name: "Pasta Primavera", ingredients: ["pasta", "sauce"])

    end
    it "#find_name" do 
      expect(Recipe.find_name("spaghettI")).to match_array()
    end
  end
end
