class CreateBookIssues < ActiveRecord::Migration
  def change
    create_table :book_issues do |t|
      t.references :book, index: true, foreign_key: true
      t.references :issue_history, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
