class AddingDescriptionToLeaveTable < ActiveRecord::Migration[5.1]
  def change
    add_column :leave_applications, :description, :string 
  end
end
