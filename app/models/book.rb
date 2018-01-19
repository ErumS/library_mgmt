class Book < ActiveRecord::Base
	belongs_to :library
	belongs_to :category
	belongs_to :member
  has_many :book_issues, dependent: :destroy
  has_many :issue_histories, through: :book_issues, dependent: :destroy
	validates :name, presence: true
end
