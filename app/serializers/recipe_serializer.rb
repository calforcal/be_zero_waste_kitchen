class RecipeSerializer
  include JSONAPI::Serializer
  attributes :name,
             :ingredients,
             :image_url,
             :cook_time,
             :public_status,
             :source_name,
             :source_url,
             :user_submitted,
             :api_id
end
