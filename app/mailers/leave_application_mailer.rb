class LeaveApplicationMailer < ApplicationMailer

	def leave_email(user, leave)
    @user = user
    @leave = leave 
    mail(to: [@user.email, "j.teh@imv.com.sg"], subject: 'IMV Leave App')
  end

  def create_leave_email(user, leave)
    @user = user 
    @leave = leave 
    mail(to: @user.hod_email, subject: "Application of Leave from #{@user.email} ")
  end 

end
