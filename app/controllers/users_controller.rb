class UsersController < ApplicationController

  before_action :authenticate_user!

  def dashboard
    @leave = LeaveApplication.new 
      # change this query method 
    leave_approval = User.where(HOD_email: current_user.email)
    leave_approval.each do |f|
      @unapproved_leave = []
      f.leave_applications.each do |list|
        if list.approved == 'N/A' 
          @unapproved_leave << list
        end 
      end
    end 
  end 

end
