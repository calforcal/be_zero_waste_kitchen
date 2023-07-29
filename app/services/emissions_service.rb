class EmissionsService
  def initialize(search)
    @search = search
  end

  def emissions_request
    post_url
  end

  def post_url
    request = conn.post do |req|
      req.body = JSON.generate({
        "emission_factor": {
          "activity_id": "waste_type_food_waste-disposal_method_landfilled",
          "source": "EPA",
          "region": "US",
          "year": 2022,
          "source_lca_activity": "end_of_life",
          "data_version": "2.2"
        },
        "parameters": {
          "weight": @search,
          "weight_unit": "g"
        }
      })
      req.body
    end
    JSON.parse(request.env.response_body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://beta4.api.climatiq.io/estimate') do |faraday|
      faraday.headers['Authorization'] = ENV['EMISSIONS_API_KEY']
      faraday.headers['Content-Type: '] = 'application/json'
    end
  end
end