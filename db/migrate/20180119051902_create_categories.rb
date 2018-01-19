class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :department
      t.references :library, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end