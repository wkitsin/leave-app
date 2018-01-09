class UsersController < ApplicationController

  before_action :authenticate_user!

  def dashboard
    @leave = LeaveApplication.new 

    if current_user.role == 'admin'

      # change this query method 
      leave_approval = User.where(title: current_user.title)
      leave_approval.each do |f|
        @unapproved_leave = []
        f.leave_applications.each do |list|
          if list.approved == false 
            @unapproved_leave << list
          end 
        end
      end 
    end 
  end 

end
