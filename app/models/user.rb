class User < ApplicationRecord
  # Include default devise modules Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :leave_applications
  before_save :calculate_leave

  def calculate_leave 
    tot_leave = total_al + bring_forward + replacement_leave 
    balance = tot_leave - leave_taken
    if id == nil 
      self.total_leave = tot_leave
      self.balace = balance
    else 
      self.update_columns(total_leave: tot_leave, balace: balance)
    end 
  end 
end