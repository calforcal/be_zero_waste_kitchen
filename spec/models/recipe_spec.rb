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
      @recipe1 = Recipe.create!(name: "Spaghetti with Marinara")
      @recipe2 = Recipe.create!(name: "Vegan Nachos")
      @recipe3 = Recipe.create!(name: "Pasta Primavera")

      @recipe1.ingredients.create!(name: "spaghetti", units: 1, unit_type: "box")
      @recipe1.ingredients.create!(name: "sauce", units: 1, unit_type: "can")

      @recipe2.ingredients.create!(name: "chips", units: 1, unit_type: "bag")
      @recipe2.ingredients.create!(name: "vegan cheese sauce", units: 1, unit_type: "cup")
      @recipe2.ingredients.create!(name: "salsa", units: 1, unit_type: "jar")

      @recipe3.ingredients.create!(name: "pasta", units: 1, unit_type: "box")
      @recipe3.ingredients.create!(name: "sauce", units: 1, unit_type: "jar")

    end

    it "#find_name" do 
      expect(Recipe.find_name("spaghettI")).to eq([@recipe1])
      expect(Recipe.find_name("nachO")).to eq([@recipe2])
      expect(Recipe.find_name("priMavera")).to eq([@recipe3])
    end

    it "#ingredient_search_details" do 
      expect(Recipe.ingredient_search_details(["sauce", "pasta"])).to match_array([@recipe3])
    end
  end
end
