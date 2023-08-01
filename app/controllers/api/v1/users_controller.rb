class Api::V1::UsersController < ApplicationController
  def show
    user = User.find_or_create_by(uid: params[:id])
    render json: UserSerializer.new(user)
  end

  def create
    render json: UserSerializer.new(User.create!(user_params)), status: :created
  end

  private

  def user_params
    params.require(:user).permit(:uid)
  end
end
