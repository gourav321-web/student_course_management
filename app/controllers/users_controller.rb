# User Controller
class UsersController < ApplicationController
  skip_forgery_protection

  before_action :find_user, only: %i[show update destroy]

  def index
    users = User.all

    if users.present?
      render json: users
    else
      render json: []
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
      render json: user.errors.messages 
    end
  end

  def update
    if @user.update(user_params)
      render json: {
        message: 'User updated successfully',
        user: @user
      }
    else
      render json: @user.errors.messages
    end
  end

  def destroy
    @user.destroy
    render json: { message: 'User deleted successfully',user:@user }
  end

  def course_with_notes
    user = User.includes(courses: :notes).find_by(id: params[:id])
        
    if user
      render json: user.to_json(include: { courses: { include: :notes } })
    else
      render json: []
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
    return if @user

    render json: { message: 'User not found' }
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
