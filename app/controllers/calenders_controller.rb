class CalendersController < ApplicationController

  def index
    current_month = Time.now.month
    month = string_interpolate_month(current_month)
    days = LeaveApplication.where("leave_date LIKE (?)", "%#{month}%").order(user_id: 'ASC')
    @compiled_leave = compile_users_leave_days(days)
  end

  def string_interpolate_month(month)
    if month <= 9
      month = "0#{month}"
    end
    string = "-#{month}-"

    return string
  end

  def compile_users_leave_days(days)
    @hash = Hash.new
    days.each do |j|
      @hash[j.user.email] = (@hash[j.user.email] || '') + ", #{j.leave_date}"
      @hash[j.user.email] == ',' if @hash[j.user.email].slice!(0)
    end
    arr = flatten_array(@hash)
    return arr
  end

  def flatten_array(hash)
    hash.each do |key, value|
      hash[key] = value.split(',')
    end

    return hash 
  end

end
