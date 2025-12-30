class NotesController < ApplicationController
  skip_forgery_protection
  def index
    @notes = Note.all
    if @notes.present?
      @notes = @notes
      render json: @notes
    else
      render json: {messege:"there is no notes present for this course"}
    end
  end

  def show
    @notes = Note.find_by_id(params[:id])
    if @notes.present?
      render json: @notes
    else
      render json: {messege:"there is no notes for this route"}
    end

  end

  def create
    @notes = Note.new(permit_params)
    @notes[:course_id] = params[:course_id]
    if(@notes.save)
      render json: {
        messege:"notes created successfully",
        notes:@notes
      }
    else
      render json: {messege:"notes not created!"}
    end
  end

  def update
  end

  def destroy
  end

  private

  def permit_params
    params.require(:note).permit(:title,:description, :course_id)
  end
end
