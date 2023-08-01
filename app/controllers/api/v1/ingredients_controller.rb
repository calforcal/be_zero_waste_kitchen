class Api::V1::IngredientsController < ApplicationController
  def index
    render json: IngredientsListSerializer.new(IngredientsFacade.new(params[:query]).ingredients_list)
  end
end