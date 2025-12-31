class User < ApplicationRecord
	validates :name, presence: true
	validates :email,presence: true,format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
	has_many :courses, dependent: :destroy
end
