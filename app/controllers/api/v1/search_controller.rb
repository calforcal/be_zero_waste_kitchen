class Api::V1::SearchController < ApplicationController
  def index
    render json: RecipeSerializer.new(RecipeSearch.new(params).search)
  end
end