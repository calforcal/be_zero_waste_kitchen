class UserSerializer
  include JSONAPI::Serializer
  attributes :uid, :name, :email
end