class LeaveApplicationsController < ApplicationController

  before_action :authenticate_user!
  before_action :leave_calculation, only: [:create]

  def create 
    leave = LeaveApplication.new(leave_params)
    leave.user_id = current_user.id 

    if leave.save 
      flash[:notice] = 'The date of leave has been submitted for approval'
      redirect_to root_path 
    else 
      flash[:notice] = 'The date of leave was not saved'
      redirect_to root_path
    end 
  end 

  def approval
    leave_day = LeaveApplication.find(params[:leave_id])
     employee = leave_day.user
      if params['approval'] == 'approve'
        leave_day.update(approved: true)
        if leave_day.category == 'Annual Leave'
          total_leave = employee.total_leave.to_i
          leave_taken = employee.leave_taken.to_i + 1
          employee.update(leave_taken: leave_taken, balace: total_leave - leave_taken)
        end 
        flash[:notice] = "#{employee.email} #{leave_day.category} was granted, and the balance annual leave is #{employee.balace}"
      else 
        leave_day.delete
        flash[:notice] = "#{employee.email} #{leave_day.category} was not granted, and the balance annual leave is #{employee.balace}"
      end 
     redirect_to root_path
  end 

  private 

  def leave_params
    params.require(:leave_application).permit(:leave_date, :category)
  end 

end
