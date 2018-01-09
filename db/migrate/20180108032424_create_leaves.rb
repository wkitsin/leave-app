class CreateLeaves < ActiveRecord::Migration[5.1]
  def change
    create_table :leave_applications do |t|
      t.datetime :leave_date 
      t.boolean :approved, default: false 
      t.belongs_to :user 
      t.timestamps
    end
  end
end