class CreateIssueHistories < ActiveRecord::Migration
  def change
    create_table :issue_histories do |t|
      t.date :issue_date
      t.date :return_date
      t.integer :copies
      t.references :member, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
