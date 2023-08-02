class Api::V1::UserRecipesController < ApplicationController
  def create
    user = find_user(params)
    user_recipe = UserRecipe.find_by(user_id: user.id, recipe_id: user_recipe_params[:recipe_id])
    if !user_recipe
      user.user_recipes.create!(user_recipe_params)
    else
      update
    end
  end

  def update
    user = find_user(params)
    user_recipe = UserRecipe.find_by(user_id: user.id, recipe_id: params[:recipe_id])
    # move logic of if not_cooked, can't rate to front end.
    user_recipe.update(user_recipe_update_params)
  end

  def destroy
    user = find_user(params)
    if user
      recipe_id = params[:recipe_id]
      user_recipe = UserRecipe.find_by(user_id: user.id, recipe_id: recipe_id)
      if user_recipe
        user_recipe.destroy
        unless UserRecipe.exists?(recipe_id: recipe_id)
          Recipe.destroy(recipe_id)
        end
        render json: { message: 'Recipe removed from user' }, status: :ok
      else
        render json: ErrorSerializer.new(error: 'UserRecipe not found'), status: :not_found
      end
    else
      render json: ErrorSerializer.new(error: 'User not found'), status: :not_found
    end
  end

  private

  def find_user(params)
    User.find_by(uid: params[:uid])
  end

  def user_recipe_params
    params.permit(:user_id, :recipe_id, :cook_status, :saved_status, :is_owner)
  end

  def user_recipe_update_params
    params.permit(:user_id, :recipe_id, :cook_status, :saved_status, :is_owner, :num_stars)
  end
end
