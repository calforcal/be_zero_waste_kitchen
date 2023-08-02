class Api::V1::RecipesController < ApplicationController
  def create
    params[:recipe][:instructions] = format_instructions(params[:recipe][:instructions])

    created_recipe = Recipe.create!(recipe_params)
    created_ingredients = if params[:ingredients]
                            params[:ingredients].map do |ingredient|
                              Ingredient.create!(name: ingredient[:name], units: ingredient[:units],
                                                 unit_type: ingredient[:unit_type])
                            end
                          end

    unless created_ingredients.nil?
      created_ingredients.each { |ingredient| created_recipe.recipe_ingredients.create!(ingredient_id: ingredient.id) }
    end

    x = UserRecipe.create!(user_id: User.find_by(uid: params[:user_uid]).id, recipe_id: created_recipe.id, is_owner: true)

    render json: RecipeSerializer.new(created_recipe), status: :created
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :instructions, :image_url, :cook_time, :public_status, :source_name,
                                   :source_url, :user_submitted, :api_id)
  end

  def format_instructions(instruction)
    add_commas = instruction.prepend(',') + ','
    add_commas.gsub(', ', ',')
  end
end
