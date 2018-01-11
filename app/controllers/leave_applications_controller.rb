class LeaveApplicationsController < ApplicationController

  before_action :authenticate_user!
  before_action :leave_calculation, only: [:create]

  def index 
    @leave = current_user.leave_applications 
    @array = LeaveApplication.includes(:user).where('users.title = ?', "#{current_user.title}").references(:users)
    @HOD = User.where(hod_email: current_user.email)
  end 

  def create 
    rearranged_dates = leave_params[:leave_date].split(',').sort.join(',')
    leave = current_user.leave_applications.new(category: leave_params[:category], leave_date: rearranged_dates)
    if leave.save 
      LeaveApplicationMailer.create_leave_email(current_user, leave).deliver_later
      flash[:notice] = "The date of leave has been submitted to #{current_user.hod_email} for approval"
    else 
      error = leave.errors.messages[:leave_date][0]
      flash[:notice] = "The leave date was not save because the date #{error}"
    end 
    redirect_to root_path
  end 

  def approval
    leave_day = LeaveApplication.find(params[:leave_id])
    total_days = leave_day.leave_date.count(',') + 1 
    employee = leave_day.user
    if params['approval'] == 'approve'
      leave_day.update(approved: 'true')
      if leave_day.category == 'Annual Leave'
        total_leave = employee.total_leave.to_i
        leave_taken = employee.leave_taken.to_i + total_days
        employee.update(leave_taken: leave_taken, balace: total_leave - leave_taken)
      end 
      flash[:notice] = "#{employee.email} #{leave_day.category} was granted, and the balance annual leave is #{employee.balace}"
    else 
      leave_day.update(approved: 'false')
      flash[:notice] = "#{employee.email} #{leave_day.category} was not granted, and the balance annual leave is #{employee.balace}"
    end 
    LeaveApplicationMailer.leave_email(employee, leave_day).deliver_later
    redirect_to root_path
  end 

  private 

  def leave_params
    params.require(:leave_application).permit(:leave_date, :category)
  end 

end
