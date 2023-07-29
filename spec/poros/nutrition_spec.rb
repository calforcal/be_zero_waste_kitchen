require 'rails_helper'

RSpec.describe Nutrition do
  it 'exists' do
    attrs = [{
      serving_size_g: 545.98
    }]

    nutrition = Nutrition.new(attrs)

    expect(nutrition).to be_a Nutrition
    expect(nutrition.total_weight_in_grams).to eq(545.98)
  end
end