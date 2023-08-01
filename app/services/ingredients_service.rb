class IngredientsService
  def ingredients_index(search)
    get_url("/v2/search/instant?query=#{search}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://trackapi.nutritionix.com') do |faraday|
      faraday.headers['x-app-id'] = ENV['NX_APP_ID']
      faraday.headers['x-app-key'] = ENV['NX_APP_KEY']
    end
  end
end