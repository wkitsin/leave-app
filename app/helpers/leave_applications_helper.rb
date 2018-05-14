module LeaveApplicationsHelper

  def employee_previous_leave_application(array, hod, count)
    if array.length != 0
      render partial: 'leave_applications/previous_leave_application', locals: {array: array, hod: hod, count: count}
    end
  end
end
