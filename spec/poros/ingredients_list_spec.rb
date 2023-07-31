require 'rails_helper'

RSpec.describe IngredientList do
  it 'exists' do
    attrs = {
      food_name: 'grape'
    }

    ingredient = IngredientList.new(attrs)

    expect(ingredient).to be_a IngredientList
    expect(ingredient.name).to eq('grape')
  end
end