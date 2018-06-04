class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def admin_array(array)
    admins = User.where(role: 'super-admin')
		admins.each do |i|
			array << i.email
		end

    return array
  end
end
