class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def leave_calculation
    balance = current_user.balace
    if balance == 0
      flash[:notice] = "The Annual Leave Application was not allowed because you do not have any remaining annual leave to spare"
      redirect_to root_path
    end
  end

  def half_or_full_day(leave_day, employee)
    total_days = leave_day.leave_date.count(',')
	  if leave_day.category == 'Annual Leave'
	    total_days = total_days + 1
	  elsif leave_day.category[0..3] == 'Half'
      total_days = total_days + 0.5
    end
    leave_taken = employee.leave_taken.to_f + total_days
    employee.update(leave_taken: leave_taken)
	end

  def days_applied(leave)
    @employee = leave.user
    @leave_date = @employee.leave_taken
    @days_applied = leave.leave_date.count(',') + 1
  end
end
