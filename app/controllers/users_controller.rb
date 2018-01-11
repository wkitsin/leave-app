class UsersController < ApplicationController

  before_action :authenticate_user!

  def dashboard
    @leave = LeaveApplication.new 
    leave_approval = User.where(hod_email: current_user.email)
    @unapprove_leave = LeaveApplication.where(approved: 'N/A').includes(:user).where("
      users.hod_email = ?" , "#{current_user.email}").references(:users)
  end 

end
