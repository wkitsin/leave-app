class UserMailer < ApplicationMailer

  def create_user(user)
    @user = user
    mail(to: @user.email, subject: 'IMV Leave App')
  end

  def replacement_leave_update(reason, date, user)
    @user = user
    @text = reason
    @date = date
    mail(to: @user.email, subject: 'Replacement Leave')
  end
end
