FactoryBot.define do
  factory :user_recipe do
    user { nil }
    recipe { nil }
    num_stars { 1 }
    cook_status { false }
    saved_status { false }
    is_owner { false }
  end
end
