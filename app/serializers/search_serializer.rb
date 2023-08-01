class SearchSerializer
  include JSONAPI::Serializer
  attributes :name,
             :api_id
end
