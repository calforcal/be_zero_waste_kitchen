class Api::V1::UsersController < ApplicationController
  def show
    user = User.find_or_create_by(uid: params[:id])
    render json: UserSerializer.new(user)
  end

  def create
    render json: UserSerializer.new(User.create!(user_params)), status: :created
  end

  def destroy
  user = find_user(params)
    if user
      User.destroy(user.id)
    else
      render json: ErrorSerializer.new(error: "User not found"), status: :not_found
    end
  end

  private

  def find_user(params)
    User.find_by(uid: params[:uid])
  end

  def user_params
    params.require(:user).permit(:uid)
  end
end
