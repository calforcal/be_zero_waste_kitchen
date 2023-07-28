require 'rails_helper'

RSpec.describe UserRecipe, type: :model do
  describe "associations" do 
    it { should belong_to :user }
    it { should belong_to :recipe }
  end

  describe "validations" do 
    it { should validate_numericality_of :num_stars }
  end
end
