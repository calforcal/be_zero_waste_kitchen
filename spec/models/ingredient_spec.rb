require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :units }
    # it { should validate_presence_of :unit_type }
    it { should validate_numericality_of :units }
  end

  describe 'associations' do
    it { should have_many :recipe_ingredients }
    it { should have_many(:recipes).through(:recipe_ingredients) }
  end
end
