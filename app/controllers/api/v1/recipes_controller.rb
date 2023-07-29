class Api::V1::RecipesController < ApplicationController
  def index
    render json: RecipeSerializer.new(RecipeSearch.new(params).search)
  end
end