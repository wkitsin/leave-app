class ApprovalController < ApplicationController

  def create
    leave_day = LeaveApplication.find(params[:leave_id])
    employee = leave_day.user
    # Check if hod approve leave
    approved = leave_day.approve_leave(params['approval'])

    if approved == true
      flash[:notice] = "#{employee.email} #{leave_day.category} was granted, and the balance annual leave is #{employee.balace}"
    else
      flash[:notice] = "#{employee.email} #{leave_day.category} was not granted, and the balance annual leave is #{employee.balace}"
    end

    LeaveApplicationMailer.leave_email(employee, leave_day).deliver_later
    redirect_to root_path
  end
end
