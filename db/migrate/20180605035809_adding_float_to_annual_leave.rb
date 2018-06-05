class AddingFloatToAnnualLeave < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :total_al, :decimal, :precision => 10, :scale => 1
  end
end
