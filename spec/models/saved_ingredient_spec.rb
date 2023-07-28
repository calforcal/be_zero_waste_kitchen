require 'rails_helper'

RSpec.describe SavedIngredient, type: :model do
  describe "validations" do 
    it { should validate_presence_of :ingredient_name }
    it { should validate_presence_of :unit_type }
    it { should validate_presence_of :units }
    it { should validate_numericality_of :units }
  end

  describe "associations" do 
    it { should belong_to :user }
  end
end
