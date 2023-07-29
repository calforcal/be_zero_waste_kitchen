class Api::V1::RecipesController < ApplicationController
  def index
    render json: RecipeSerializer.new(SpoonSearch.new(params).search)
  end
end