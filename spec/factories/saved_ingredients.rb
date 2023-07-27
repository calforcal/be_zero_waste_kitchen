FactoryBot.define do
  factory :saved_ingredient do
    user { nil }
    ingredient_name { "MyString" }
    unit_type { "MyString" }
    units { 1.5 }
  end
end
