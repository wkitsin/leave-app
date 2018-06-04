class LeaveApplicationMailer < ApplicationMailer

	def leave_email(user, leave)
    @user = user
    @leave = leave
		@admin = User.where(role: 'admin')
		@array = [@user.email]
		mail_array = admin_array(@array)
    mail(to: mail_array, subject: 'IMV Leave App')
  end

  def create_leave_email(user, leave)
    @user = user
    @leave = leave
    mail(to: @user.hod_email, subject: "Application of Leave from #{@user.email} ")
  end

	def delete_leave_mail(user,leave)
		@user = user
		@leave = leave
		@array = [@user.email]
		mail_array = admin_array(@array)
		mail(to: mail_array, subject: "Cancellation of leave from #{@user.email}")
	end

	def update_leave_mail(user, leave, previous_date)
		@user = user
		@leave = leave
		@previous_date = previous_date
		mail(to: @user.hod_email, subject: "#{@user.email} made changes to his/her applied leave")
	end
end
