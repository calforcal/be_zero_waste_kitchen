require 'rails_helper'

RSpec.describe EmissionsService do
  describe 'class methods' do
    describe '#emissions_request' do
      it 'gets emissions data based on the weight of food waste' do
        VCR.use_cassette("spec/fixtures/vcr_cassettes/EmissionsService/class_methods/_emissions_request/gets_emissions_data_based_on_the_weight_of_food_waste.yml") do
          query = 4000
          search = EmissionsService.new(query).emissions_request

          expect(search).to be_a Hash

          expect(search).to have_key(:co2e)
          expect(search[:co2e]).to be_a Float

          expect(search).to have_key(:co2e_unit)
          expect(search[:co2e_unit]).to be_a String
        end
      end
    end
  end
end