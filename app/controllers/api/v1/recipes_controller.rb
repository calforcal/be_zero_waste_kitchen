class Api::V1::RecipesController < ApplicationController
  def create
    params[:recipe][:instructions] = format_instructions(params[:recipe][:instructions])

    created_recipe = Recipe.create!(recipe_params)
    created_ingredients = if params[:ingredients]
      params[:ingredients].map { |ingredient| Ingredient.create!(name: ingredient[:name], units: ingredient[:units], unit_type: ingredient[:unit_type]) }
    end

    if !created_ingredients.nil?
      created_ingredients.each { |ingredient| created_recipe.recipe_ingredients.create!(ingredient_id: ingredient.id) }
    end

    render json: RecipeSerializer.new(created_recipe), status: :created
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :instructions, :image_url, :cook_time, :public_status, :source_name, :source_url, :user_submitted, :api_id)
  end

  def format_instructions(instruction)
    add_commas = instruction.prepend(',') + ','
    add_commas.gsub(', ', ',')
  end
end
