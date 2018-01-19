class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string :name
      t.text :address
      t.string :phone_no
      t.timestamps null: false
    end
  end
end