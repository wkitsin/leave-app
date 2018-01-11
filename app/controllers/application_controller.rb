class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def leave_calculation
    balance = current_user.balace 
    if balance == 0 
      flash[:notice] = "The Annual Leave Application was not allowed because you do not have any remaining annual leave to spare"
      redirect_to root_path 
    end 
  end 
end
