class UsersController < ApplicationController
  skip_forgery_protection

  before_action :find_user, only: [:show, :update, :destroy]

  def index
    users = User.all

    if users.present?
      render json: users
    else
      render json: { message: "No users found" }
    end
  end

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user
    else
      render json: { message: "User not created" }
    end
  end

  def update
    if @user.update(user_params)
      render json: {
        message: "User updated successfully",
        user: @user
      }
    else
      render json: { message: "User update failed" }
    end
  end

  def destroy
    @user.destroy
    render json: { message: "User deleted successfully" }
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
    unless @user
      render json: { message: "User not found" }
    end
  end

  def user_params
    params.require(:user).permit(:name,:email)
  end
end