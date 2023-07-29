require 'rails_helper'

RSpec.describe EmissionsFacade do
  describe 'Emissions' do
    describe '#total_emissions' do
      it 'can return the total emissions saved based on food weight' do
        VCR.use_cassette("spec/fixtures/vcr_cassettes/EmissionsFacade/Emissions/_total_emissions/can_return_the_total_emissions_saved_based_on_food_weight.yml") do
          query = 4000
          data = EmissionsFacade.new(query).total_emissions

          expect(data).to be_a Emission
          expect(data.co2_kg).to be_a Float
          expect(data.co2_kg).to eq(2.55736224134458)
        end
      end
    end
  end
end