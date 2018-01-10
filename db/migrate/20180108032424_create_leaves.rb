class CreateLeaves < ActiveRecord::Migration[5.1]
  def change
    create_table :leave_applications do |t|
      t.string :leave_date 
      t.string :approved, default: 'N/A' 
      t.belongs_to :user 
      t.timestamps
    end
  end
end
