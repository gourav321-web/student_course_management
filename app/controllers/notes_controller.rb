# Notes Controller
class NotesController < ApplicationController
  skip_forgery_protection

  before_action :find_user
  before_action :find_course
  before_action :find_note, only: %i[show update destroy]

  def index
    notes = Note.all

    if notes.present?
      notes = notes.where(status:0).or(notes.where(course_id:params[:course_id]))
      render json: notes
    else
      render json: []
    end
  end

  def show
    render json: @note
  end

  def create
    note = @course.notes.new(note_params)

    if note.save
      render json: {
        message: 'Note created successfully',
        note: note
      }
    else
      render json: { message: 'Note not created' }
    end
  end

  def update
    if @note.update(note_params)
      render json: {
        message: 'Note updated successfully',
        note: @note
      }
    else
      render json: { message: 'Note not updated' }
    end
  end

  def destroy
    @note.destroy
    render json: { message: 'Note deleted successfully' }
  end

  def filter
    notes = @course.notes

    notes = notes.where('DATE(created_at) = ?', params[:date]) if params[:date].present?

    notes = notes.where(created_at: params[:last_days].to_i.days.ago..) if params[:last_days].present?

    if notes.present?
      render json: notes
    else
      render json: { message: 'No notes found for given date' }
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:user_id])
    return if @user

    render json: { message: 'User not found' }
  end

  def find_course
    @course = @user.courses.find_by(id: params[:course_id])
    return if @course

    render json: { message: 'Course not found' }
  end

  def find_note
    @note = @course.notes.find_by(id: params[:id])
    return if @note

    render json: { message: 'Note not found' }
  end

  def note_params
    params.require(:note).permit(:title, :description, :status)
  end
end
