class Api::V1::SearchController < ApplicationController
  def index
    render json: SearchSerializer.new(RecipeSearch.new(params).search)
  end
end