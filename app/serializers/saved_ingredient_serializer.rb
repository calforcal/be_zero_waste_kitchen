class SavedIngredientSerializer
  include JSONAPI::Serializer
  attributes :id, :ingredient_name, :units, :unit_type, :created_at, :updated_at
end