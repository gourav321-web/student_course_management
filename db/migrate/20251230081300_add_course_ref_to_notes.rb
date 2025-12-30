class AddCourseRefToNotes < ActiveRecord::Migration[7.1]
  def change
    add_reference :notes, :course, null: false, foreign_key: true
  end
end
