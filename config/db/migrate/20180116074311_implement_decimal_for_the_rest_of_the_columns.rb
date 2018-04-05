class ImplementDecimalForTheRestOfTheColumns < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :total_leave, :decimal, :precision => 10, :scale => 1
  	change_column :users, :leave_taken, :decimal, :precision => 10, :scale => 1
  	change_column :users, :balace, :decimal, :precision => 10, :scale => 1
  end
end
