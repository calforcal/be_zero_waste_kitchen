FactoryBot.define do
  factory :recipe do
    name { "MyString" }
    instructions { "MyString" }
    image_url { "MyString" }
    api_rating { 1.5 }
    cook_time { 1 }
    public_status { false }
    source_name { "MyString" }
    source_url { "MyString" }
  end
end
