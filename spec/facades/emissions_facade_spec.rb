require 'rails_helper'

RSpec.describe EmissionsFacade do
  describe 'Emissions' do
    describe '#total_emissions' do
      it 'can return the total emissions saved based on food weight', :vcr do
        query = 4000
        data = EmissionsFacade.new(query).total_emissions

        expect(data).to be_a Emission
        expect(data.co2_kg).to be_a Float
        expect(data.co2_kg).to eq(2.55736224134458)
      end
    end
  end
end
