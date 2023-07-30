require 'rails_helper'

RSpec.describe NutritionFacade do
  describe 'Nutrition' do
    describe '#total_ingredients' do
      it 'can produce the weight of all ingredients given', :vcr do
        query = '1 lbs Chicken'
        data = NutritionFacade.new(query).total_ingredients

        expect(data).to be_a Nutrition

        expect(data.total_weight_in_grams).to be_a(Float)
        expect(data.total_weight_in_grams).to eq(453.592)
      end
    end
  end
end
