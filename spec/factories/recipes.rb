FactoryBot.define do
  factory :recipe do
    name { 'MyString' }
    instructions { 'MyString' }
    image_url { 'MyString' }
    cook_time { 1 }
    public_status { true }
    source_name { 'MyString' }
    source_url { 'MyString' }
  end
end
