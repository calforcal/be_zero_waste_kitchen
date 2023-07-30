class UserSerializer
  include JSONAPI::Serializer
  attributes :uid, :name, :email

  attribute :stats do |object|
    object.user_stats
  end

  attribute :cooked_recipes do |object|
    object.recipes_cooked
  end

  attribute :created_recipes do |object|
    object.recipes_created
  end

  attribute :saved_recipes do |object|
    object.recipes_saved
  end

  attribute :num_cooked_recipes do |object|
    object.num_recipes_cooked
  end

  attribute :num_created_recipes do |object|
    object.num_recipes_created
  end

  attribute :num_saved_recipes do |object|
    object.num_recipes_saved
  end
end
