class UserRecipe < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  validates :num_stars, numericality: true

  def self.create_user_recipe(params)
    user = User.find_by(uid: params[:uid])
    recipe = Recipe.find_by(recipe_id: params[:recipe_id])
    association = UserRecipe.find_by(user_id: user.id, recipe_id: recipe.id)

    if params[:num_stars] && association.cook_status == true
      association.update(num_stars: params[:num_stars])
    elsif params[:num_stars] 
      "You must have cooked a recipe before rating it."
    elsif params[:cook_status] && association
      association.update(cook_status: params[:cook_status])
    elsif params[:saved_status] && association
      association.update(saved_status: params[:saved_status])
    elsif !association
      UserRecipe.create!(params)
    end
  end
end
