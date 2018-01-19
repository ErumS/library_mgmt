class Library < ActiveRecord::Base
	has_many :books, dependent: :destroy
	has_many :members, dependent: :destroy
	has_many :categories, dependent: :destroy
	validates :name, presence: true
	validates :address, presence: true
	validates :phone_no, presence: true, length: {in: 8..15}
end
