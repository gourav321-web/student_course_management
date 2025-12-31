class CoursesController < ApplicationController
  skip_forgery_protection

  before_action :find_user
  before_action :find_course, only: [:show, :update, :destroy]

  def index
    courses = @user.courses

    if courses.present?
      render json: courses
    else
      render json: { message: "No courses present yet" }
    end
  end

  def show
    render json: @course
  end

  def create
    course = @user.courses.new(course_params)

    if course.save
      render json: {
        message: "Course created successfully",
        course: course
      }
    else
      render json: { message: "Course not created" }
    end
  end

  def update
    if @course.update(course_params)
      render json: {
        message: "Course updated successfully",
        course: @course
      }
    else
      render json: { message: "Course not updated" }
    end
  end

  def destroy
    @course.destroy
    render json: { message: "Course deleted successfully" }
  end

  def filter
    courses = @user.courses

    if params[:date].present?
      courses = courses.where("DATE(created_at) = ?", params[:date])
    end

    if params[:last_days].present?
      courses = courses.where(
        "created_at >= ?",
        params[:last_days].to_i.days.ago
      )
    end

    if courses.present?
      render json: courses
    else
      render json: { message: "No courses found for given date" }
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:user_id])
    unless @user
      render json: { message: "User not found" }
    end
  end

  def find_course
    @course = @user.courses.find_by(id: params[:id])
    unless @course
      render json: { message: "Course not found" }
    end
  end

  def course_params
    params.require(:course).permit(:name)
  end
end