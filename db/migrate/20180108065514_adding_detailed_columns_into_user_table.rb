class AddingDetailedColumnsIntoUserTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :title, :string 
    add_column :users, :department, :string 
    add_column :users, :hod_email, :string 
    add_column :users, :total_al, :integer, default: 0
    add_column :users, :bring_forward, :integer, default: 0
    add_column :users, :replacement_leave, :integer, default: 0
    add_column :users, :total_leave, :integer, default: 0
    add_column :users, :leave_taken, :integer, default: 0
    add_column :users, :balace, :integer, default: 0
  end
end
