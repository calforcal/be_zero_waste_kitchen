class Api::V1::UserIngredientsController < ApplicationController
  before_action :find_user

  def create
    unless user_ingredients_params[:uid].present? && user_ingredients_params[:ingredients].is_a?(Array)
      render json: { error: 'Invalid request body' }, status: :unprocessable_entity
      return
    end

    user_ingredients_params[:ingredients].each do |ingredient|
      @user.saved_ingredients.create(
        ingredient_name: ingredient[:ingredient_name],
        units: ingredient[:units],
        unit_type: ingredient[:unit_type]
      )
    end
    render json: { message: 'Saved ingredients successfully' }, status: :created
  end

  private

  def find_user
    @user = User.find_by(uid: params[:uid])
    unless @user
      render json: { error: 'User not found' }, status: :not_found
      return
    end
  end

  def user_ingredients_params
    params.permit(:uid, ingredients: %i[ingredient_name units unit_type])
  end
end
