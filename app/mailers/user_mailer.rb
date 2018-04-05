class UserMailer < ApplicationMailer

  def create_user(user)
    @user = user
    mail(to: @user.email, subject: 'IMV Leave App')
  end
end
