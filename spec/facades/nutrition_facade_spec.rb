require 'rails_helper'

RSpec.describe NutritionFacade do
  describe 'Nutrition' do
    describe '#total_ingredients' do
      it 'can produce the weight of all ingredients given' do
        VCR.use_cassette("spec/fixtures/vcr_cassettes/NutritionFacade/Nutrition/_total_ingredients/can_produce_the_weight_of_all_ingredients_given.yml") do
          query = "1 lbs Chicken"
          data = NutritionFacade.new(query).total_ingredients

          expect(data).to be_a Nutrition

          expect(data.total_weight_in_grams).to be_a(Float)
          expect(data.total_weight_in_grams).to eq(453.592)
        end
      end
    end
  end
end