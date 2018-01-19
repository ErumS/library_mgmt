class BookIssue < ActiveRecord::Base
  belongs_to :book
  belongs_to :issue_history
end