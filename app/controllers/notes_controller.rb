class NotesController < ApplicationController
  def index
    @notes = Note.all
    if @notes.present?
      @notes = @notes.where(course_id == params[:course_id])
      render json: @notes
    else
      render json: {messege:"there is no notes present for this course"}
    end
  end

  def show
    @notes = @notes.find_by_id(params[:id])
    unless @notes.present?
      render json: {messege:"there is no notes for this route"}
    end

    @notes = @notes.where(course_id == params[:course_id])
    render json: {messege:"there is no notes present"}
  end

  def create
  end

  def update
  end

  def destroy
  end
end
