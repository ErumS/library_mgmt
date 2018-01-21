class IssueHistory < ActiveRecord::Base
	belongs_to :member
  has_many :book_issues, dependent: :destroy
	has_many :books, through: :book_issues, dependent: :destroy
	validates :issue_date, presence: true
	validates :return_date, :member_id, presence: true
  validates :copies, presence: true, inclusion: {in: 1..3}
end
