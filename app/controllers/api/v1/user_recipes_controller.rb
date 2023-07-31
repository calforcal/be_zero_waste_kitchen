class UserRecipesController < ApplicationController
  def create
    UserRecipe.create_user_recipe(params)
  end

  private 

  def user_recipe_params
    params.permit(:user_id, :recipe_id, :num_stars, :cook_status, :saved_status, :is_owner)
  end
end
