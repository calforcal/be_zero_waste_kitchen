class Api::V1::UsersController < ApplicationController
  def show
    render json: UserSerializer.new(User.find(params[:id]))
  end

  def create
    render json: UserSerializer.new(User.create!(user_params)), status: :created
  end

  private
  def user_params
    params.require(:user).permit(:uid, :name, :email)
  end
end