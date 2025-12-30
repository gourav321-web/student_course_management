class CoursesController < ApplicationController
  skip_forgery_protection

  def index
    @course = Course.all.where(user_id:params[:user_id])
    if @course.present?
      render json: @course
    else
      render json: {messege:"there is no courses present yet"}
    end
  end

  def show
    @course = Course.find_by_id(params[:id])
    if @course.present?
      render json: @course
    else
      render json: {messege:"this course are not created"}
    end
  end

  def create
    @course = Course.new(permit_params)
    @course[:user_id] = params[:user_id]
    if @course.save
      render json: @course
    else
      render json: {messeg:"course not created!"}
    end
  end

  def update
    @course = Course.find_by_id(params[:id])
    if ((@course.present?))
      if @course.update(permit_params)
        render json: {
          messege:"successfully Updated",
          Course:@course
        }
      else
        render json:"course not updated"
      end
    else
      render json: {messege: "Course not found"}
    end
  end

  def destroy
    @course = Course.find_by_id(params[:id])
    if ((@course.present?))
      @course.destroy
      render json: {messege:"course deleted successfully"}
    else
      render json: {messege:"course not found"}
    end
  end

  private
  def permit_params
    params.require(:course).permit(:name)
  end

end
