require 'rails_helper'

RSpec.describe Emission do
  it 'exists' do
    attrs = {
      co2e: 14.2555555
    }

    emission = Emission.new(attrs)

    expect(emission).to be_a Emission
    expect(emission.co2_kg).to eq(14.2555555)
  end
end