FactoryBot.define do
  factory :recipe do
    name { 'Banana Foster' }
    instructions { ",1. Eat,2. Enjoy," }
    image_url { 'banana_foster_image.com' }
    cook_time { 1 }
    public_status { true }
    source_name { 'Chef Mateo' }
    source_url { 'www.chefmateo.com' }
  end
end
