class LeaveApplicationsController < ApplicationController

  before_action :authenticate_user!

  def index
    @leave = current_user.leave_applications.order(id: :ASC)
    @array = LeaveApplication.includes(:user).where('users.hod_email = ?', "#{current_user.email}").references(:users)
    @HOD = User.where(hod_email: current_user.email).order(id: :ASC)
    @leave_id = @leave.count + @array.count
    @count = 1
  end

  def create
    leave = current_user.leave_applications.new(leave_params)
    if leave.save
      LeaveApplicationMailer.create_leave_email(current_user, leave).deliver_later
      flash[:notice] = "The date of leave has been submitted to #{current_user.hod_email} for approval"
    else
      error = leave.errors.messages[:leave_date][0]
      flash[:notice] = "The leave date was not save because the date #{error}"
    end
    redirect_to root_path
  end

  def edit
    @leave = LeaveApplication.find(params[:id])
  end

  def update
    leave = LeaveApplication.find(params[:id])
    previous_date = [leave.leave_date, leave.category]

    # returns leave_date and dats_applied
    days_applied(leave)

    if leave.approved == 'Approved :)'
      # if approved then change to waiting for approval and send new email to hod
      @employee.update(leave_taken: @leave_date - @days_applied)
    end
    leave.update(leave_params.merge({approved: 'N/A'}))
    LeaveApplicationMailer.update_leave_mail(@employee, leave, previous_date).deliver_later
    redirect_to root_path
  end

  def destroy
    # querying data from the particular user and their applied leave date
    leave = LeaveApplication.find(params[:id])

    days_applied(leave)

    if leave.destroy
      # update the leave dates if only it was approved
      if leave.approved == 'Approved :)'
        @employee.update(leave_taken: @leave_date - @days_applied)
      end
      flash[:notice] = " Your #{leave.category} was cancelled,
      and the balance annual leave is #{@employee.balace}"
    else
       error = leave.errors.messages[:leave_date][0]
      flash[:notice] = " Your #{leave.category} cannot be cancelled, because #{error} "
    end
    # email sending
    LeaveApplicationMailer.delete_leave_mail(@employee, leave).deliver_later
    redirect_to root_path
  end


  private

  def leave_params
    params.require(:leave_application).permit(:leave_date, :category, :description)
  end

end
