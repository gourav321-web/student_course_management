# Course Controller
class CoursesController < ApplicationController
  skip_forgery_protection

  before_action :find_user
  before_action :find_course, only: %i[show update destroy]

  def index
    courses = Course.all

    if courses.present?
      courses = courses.where(user_id:params[:user_id]).or(courses.where(status:0))
      render json: courses
    else
      render json: { message: 'No courses Found' }
    end
  end

  def show
    render json: @course
  end

  def create
    course = @user.courses.new(course_params)

    if course.save
      render json: {
        message: 'Course created successfully',
        course: course
      }
    else
      render json: { message: 'Course not created' }
    end
  end

  def update
    if @course.update(course_params)
      render json: {
        message: 'Course updated successfully',
        course: @course
      }
    else
      render json: { message: 'Course not updated' }
    end
  end

  def destroy
    @course.destroy
    render json: { message: 'Course deleted successfully' }
  end

  def filter
    courses = @user.courses

    courses = courses.where('DATE(created_at) = ?', params[:date]) if params[:date].present?

    courses = courses.where(created_at: params[:last_days].to_i.days.ago..) if params[:last_days].present?

    if courses.present?
      render json: courses
    else
      render json: { message: 'No courses found for given date' }
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:user_id])
    return if @user

    render json: { message: 'User not found' }
  end

  def find_course
    @course = @user.courses.find_by(id: params[:id])
    return if @course

    render json: { message: 'Course not found' }
  end

  def course_params
    params.require(:course).permit(:name, :status)
  end
end
