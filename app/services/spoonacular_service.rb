class SpoonacularService
  def conn
    Faraday.new(url: "https://api.spoonacular.com/recipes/") do |faraday|
      faraday.params["api_key"] = ENV["SPOON-KEY"]
    end
  end
end