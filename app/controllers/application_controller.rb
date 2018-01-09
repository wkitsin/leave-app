class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def leave_calculation
    balance = current_user.balace 

    if balance == 0 
      flash[:notce] = 'Your annual leave has #{balance} dayf left'
      redirect_to root_path 
    end 
  end 
end
