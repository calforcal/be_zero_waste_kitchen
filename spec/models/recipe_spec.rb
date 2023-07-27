require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe "validations" do 
    it { should validate_presence_of :name }
    it { should validate_presence_of :instructions }
    it { should validate_presence_of :cook_time }
    it { should validate_numericality_of :cook_time }
    it { should validate_presence_of :public_status }
  end

  describe "associations" do 
    it { should have_many :user_recipes }
    it { should have_many(:users).through(:user_recipes) }
    it { should have_many :recipe_ingredients }
    it { should have_many(:ingredients).through(:recipe_ingredients) }
  end
end
