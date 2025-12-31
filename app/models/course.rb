# Course Model
class Course < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :notes, dependent: :destroy
  enum :status, {pub: 0, pri:1}
end
