class UsersController < ApplicationController
  skip_forgery_protection

  def index
    @user = User.all
    if @user.present?
      render json: @user
    else
      render json: {messege:"No user found"}
    end

  end

  def show
    @user = User.find_by_id(params[:id])
    if @user.present?
      render json: @user
    else
      render json: {messege:"User not found!"}
    end

  end

  def create
    @user = User.new(permit_params)
    if @user.save
      render json: @user
    else
      render json: {messege:"User not created!"}
    end
  end

  def update
    @user = User.find(params[:id])
    unless @user
      render json: {messege:"User not found"}
    end

    if @user.update(permit_params)
      render json: {msg:"user successfully updated",obj:@user}
    else
      render json: {msg:"failure #{@user}"}
    end
  end

  def destroy
    @user = User.find(params[:id])
    unless(@user)
      render json: {messege:"user not found"}
    end

    if @user.destroy
      render json: {
        messege:"user deleted succesfully",
        user:@user
      }
    else
      render json:{
        messege:"user not deleted"
      }
    end

  end

  private
  def permit_params
    params.require(:user).permit(:name)
  end
end
