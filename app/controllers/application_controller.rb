class ApplicationController < ActionController::Base

  def days_applied(leave)
    @employee = leave.user
    @leave_date = @employee.leave_taken
    @days_applied = leave.leave_date.count(',') + 1
  end
end
