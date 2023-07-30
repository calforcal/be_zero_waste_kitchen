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
      @recipe4 = Recipe.create!(name: "Minestrone")

      @recipe1.ingredients.create!(name: "spaghetti", units: 1, unit_type: "box")
      @recipe1.ingredients.create!(name: "sauce", units: 1, unit_type: "can")

      @recipe2.ingredients.create!(name: "chips", units: 1, unit_type: "bag")
      @recipe2.ingredients.create!(name: "vegan cheese sauce", units: 1, unit_type: "cup")
      @recipe2.ingredients.create!(name: "salsa", units: 1, unit_type: "jar")

      @recipe3.ingredients.create!(name: "pasta", units: 1, unit_type: "box")
      @recipe3.ingredients.create!(name: "sauce", units: 1, unit_type: "jar")
      @recipe3.ingredients.create!(name: "garlic", units: 1, unit_type: "clove")

      @recipe4.ingredients.create!(name: "garlic", units: 1, unit_type: "clove")
      @recipe4.ingredients.create!(name: "pasta", units: 1, unit_type: "cup")
      @recipe4.ingredients.create!(name: "celery", units: 1, unit_type: "cup")
      @recipe4.ingredients.create!(name: "beans", units: 1, unit_type: "can")

    end

    it "#find_name" do 
      expect(Recipe.find_name("spaghettI")).to eq([@recipe1])
      expect(Recipe.find_name("nachO")).to eq([@recipe2])
      expect(Recipe.find_name("priMavera")).to eq([@recipe3])
    end

    it "#ingredient_search_details" do 
      expect(Recipe.ingredient_search_details(["sauce", "pasta", "garlic"])).to eq([@recipe3, @recipe4, @recipe1])
    end
  end
end
