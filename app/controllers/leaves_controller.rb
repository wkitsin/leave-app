class LeavesController < ApplicationController

  before_action :authenticate_user!

  def create 
    leave = Leave.new(leave_params)
    leave.user_id = current_user.id 

    if leave.save 
      flash[:notice] = 'The date of leave has been submitted for approval'
      redirect_to root_path 
    else 
      flash[:notice] = 'The date of leave was not saved'
      redirect_to root_path
    end 
  end 

  private 

  def leave_params
    params.require(:leave).permit(:leave_date)
  end 
end
