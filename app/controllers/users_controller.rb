class UsersController < ApplicationController

  before_action :authenticate_user!

  def dashboard
    @leave = LeaveApplication.new 
    leave_approval = User.where(hod_email: current_user.email)
    @unapprove_leave = LeaveApplication.where(approved: 'N/A').includes(:user).where("
      users.hod_email = ?" , "#{current_user.email}").references(:users)
  end 

  def index 
    @users = User.order(:id)
  end 

  def edit 
    @user = User.find(params[:id])
  end 

  def update 
    user = User.find(params[:id])
    user.update(update_params)
    if user 
      flash[:notice] = "#{user.email}'s details has been updated" 
    else 
      flash[:notice] = user.errors.messages
    end 
      redirect_to users_path
  end 

  private 

  def update_params
    params.require(:user).permit(:email, :title, :total_al, :replacement_leave, :bring_forward)
  end 

end
