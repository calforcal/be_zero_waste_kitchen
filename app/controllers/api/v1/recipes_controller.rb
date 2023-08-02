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

    render json: RecipeSerializer.new(created_recipe), status: :created
  end

  def update
    # Maybe, add find_recipe callback, so it stops if a recipe does not exists?
    # For example, "The Recipe you requested does not exist."
    # require 'pry'; binding.pry
    if recipe_params[:api_id].nil?
      
      # updated_recipe = @recipe.update(recipe_params)
      # ^^^ Ultimately would like to refactor to this code, after a find_recipe before_callback
      # has been successfully created. For now going with code below:
      recipe = Recipe.find(params[:id]).update!(recipe_params)
      updated_recipe = Recipe.find(params[:id])
      
      if params.has_key?(:ingredients) && !params[:ingredients].empty?
        updated_ingredients = ingredients_params(params)
        updated_recipe.ingredients.destroy_all
        updated_ingredients.each do |updated_ingredient|
          updated_recipe.ingredients.create!(updated_ingredient)
        end
      end
      render json: RecipeSerializer.new(updated_recipe), status: :ok
    else
      # SAD PATH - code to let user know they "You do not have access to update this recipe"
      # Maybe this is a front-end problem???
      # render json ErrorSerializer.new(:alert)
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :instructions, :image_url, :cook_time, :public_status, :source_name,
                                   :source_url, :user_submitted, :api_id)
  end

  def ingredients_params(params)
    params.require(:ingredients).map do |ingredient|
      ingredient.permit(:name, :instructions, :units, :unit_type)
    end
  end

  def format_instructions(instruction)
    add_commas = instruction.prepend(',') + ','
    add_commas.gsub(', ', ',')
  end

  #Potential method for #find_recipe to be used as a callback before the recipes#show and recipes#update

end
