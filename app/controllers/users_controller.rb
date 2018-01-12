class UsersController < ApplicationController

  before_action :authenticate_user!

  def dashboard
    @leave = LeaveApplication.new 
    leave_approval = User.where(hod_email: current_user.email)
    @unapprove_leave = LeaveApplication.where(approved: 'N/A').includes(:user).where("
      users.hod_email = ?" , "#{current_user.email}").references(:users)
  end 

  def new 
    @user = User.new 
  end 

  def create 
    user = User.new(update_params)
    user.password = '123123'
    user.password_confirmation = '123123'
    if user.save 
      flash[:notice] = "#{user.email} was successfully created and the default password is 123123"
    else 
      flash[:notice] = "The #{user.errors.full_messages[0]} while creating user #{user.email}"
    end 
    redirect_to root_path 
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
