class ApplicationController < ActionController::Base

  def leave_calculation
    balance = current_user.balace
    if balance == 0
      flash[:notice] = "The Annual Leave Application was not allowed because you do not have any remaining annual leave to spare"
      redirect_to root_path
    end
  end

  def days_applied(leave)
    @employee = leave.user
    @leave_date = @employee.leave_taken
    @days_applied = leave.leave_date.count(',') + 1
  end
end
