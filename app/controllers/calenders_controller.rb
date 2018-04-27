class CalendersController < ApplicationController

  def index
    current_month = Time.now.month
    month = "-#{current_month.to_s.rjust(2, "0")}-"
    users = User.joins(:leave_applications).group("users.id").where("leave_date LIKE (?)", "%#{month}%")
    @hash = {}
    users.each do |user|
      @hash[user.email] = user.leave_applications.where("leave_date LIKE (?)", "%#{month}%").pluck(:leave_date).join(',').split(',')
    end
  end
end
