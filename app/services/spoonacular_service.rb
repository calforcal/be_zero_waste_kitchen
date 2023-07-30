class SpoonacularService
  def conn
    Faraday.new(url: 'https://api.spoonacular.com/recipes/') do |faraday|
      faraday.params['apiKey'] = ENV['SPOON-KEY']
      faraday.params['number'] = 10
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def recipes_by_ingredients(ingr_array)
    search = ingr_array.join(',+')
    get_url("findByIngredients?ingredients=#{search}")
  end

  def recipe_by_id(id)
    get_url("#{id.to_i}/information")
  end

  def recipes_by_name(name)
    search = name.split(' ')
    query = search.join(',+')
    get_url("complexSearch?query=#{query}")
  end
end
