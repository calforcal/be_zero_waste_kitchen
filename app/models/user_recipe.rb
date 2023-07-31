class UserRecipe < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  def self.create_user_recipe(params)
    user = User.find_by(uid: params[:uid])
    recipe = Recipe.find(params[:recipe_id])
    association = UserRecipe.find_by(user_id: user.id, recipe_id: recipe.id)

    if params[:num_stars] && association&.cook_status == true
      association.update(num_stars: params[:num_stars])
  #  figure out how to handle sad path if not yet cooked
  # probably in the controller...
    elsif params[:cook_status] && association
      association.update(cook_status: params[:cook_status])
    elsif params[:saved_status] && association
      association.update(saved_status: params[:saved_status])
    elsif !association
      UserRecipe.create!(user_id: user.id,
                        recipe_id: recipe.id,
                        cook_status: recipe[:cook_status],
                        saved_status: recipe[:saved_status],
                        num_stars: recipe[:num_stars])
    end
  end
end
