class Category < ActiveRecord::Base
	has_many :books, dependent: :destroy
	belongs_to :library
	validates :department, presence: true
end
