class Member < ActiveRecord::Base
	has_many :books, dependent: :destroy
	belongs_to :library
	has_many :issue_histories, dependent: :destroy
	validates :name, :library_id, presence: true
	validates :phone_no, presence: true, length: {in: 8..15}
end
