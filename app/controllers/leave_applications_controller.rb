class LeaveApplicationsController < ApplicationController

  before_action :authenticate_user!
  before_action :leave_calculation, only: [:create]

  def index 
    @leave = current_user.leave_applications  
    @employee_leave =  User.where(title: current_user.title)
    @array = []
    @employee_leave.each do |f|
      if f.leave_applications.length != 0 
        @array << f.leave_applications
      end 
    end 

    @HOD = User.where(HOD_email: current_user.email)
  end 

  def create 
    leave = current_user.leave_applications.new(leave_params)

    if leave.save 
      LeaveApplicationMailer.create_leave_email(current_user, leave).deliver_later
      flash[:notice] = "The date of leave has been submitted to #{current_user.HOD_email} for approval"
      redirect_to root_path 
    else 
      error = leave.errors.messages[:leave_date][0]
      flash[:notice] = "The leave date was not save because the date #{error}"
      redirect_to root_path
    end 
  end 

  def approval
    leave_day = LeaveApplication.find(params[:leave_id])
    employee = leave_day.user
      if params['approval'] == 'approve'
        leave_day.update(approved: 'true')
        if leave_day.category == 'Annual Leave'
          total_leave = employee.total_leave.to_i
          leave_taken = employee.leave_taken.to_i + 1
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
