class AddingCategoryToLeaveTable < ActiveRecord::Migration[5.1]
  def change
    add_column :leave_applications, :category, :string
  end
end
