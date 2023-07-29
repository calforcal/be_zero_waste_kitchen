require 'rails_helper'

describe NutritionService do
  describe 'instance methods' do
    describe '#ingredients weight' do
      it 'can take in a string of ingredients and return nutrition facts', :vcr do
        query = "2 lbs chicken"
        search = NutritionService.new.ingredients_weight(query)
        expect(search).to be_an(Array)
        expect(search.first).to be_a(Hash)

        search.each do |result|
          expect(result).to have_key(:name)
          expect(result[:name]).to be_a(String)

          expect(result).to have_key(:calories)
          expect(result[:calories]).to be_a(Float)

          expect(result).to have_key(:serving_size_g)
          expect(result[:serving_size_g]).to be_a(Float)

          expect(result).to have_key(:fat_total_g)
          expect(result[:fat_total_g]).to be_a(Float)

          expect(result).to have_key(:fat_saturated_g)
          expect(result[:fat_saturated_g]).to be_a(Float)

          expect(result).to have_key(:protein_g)
          expect(result[:protein_g]).to be_a(Float)

          expect(result).to have_key(:sodium_mg)
          expect(result[:sodium_mg]).to be_a(Integer)

          expect(result).to have_key(:potassium_mg)
          expect(result[:potassium_mg]).to be_a(Integer)

          expect(result).to have_key(:cholesterol_mg)
          expect(result[:cholesterol_mg]).to be_a(Integer)

          expect(result).to have_key(:carbohydrates_total_g)
          expect(result[:carbohydrates_total_g]).to be_a(Float)

          expect(result).to have_key(:fiber_g)
          expect(result[:fiber_g]).to be_a(Float)

          expect(result).to have_key(:sugar_g)
          expect(result[:sugar_g]).to be_a(Float)
        end
      end
    end
  end
end