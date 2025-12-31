# Notes Model
class Note < ApplicationRecord
  validates :title, :description, presence: true
  belongs_to :course
  enum :status, {pub: 0, pri:1}
end
