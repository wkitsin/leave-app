class UsersController < ApplicationController

  before_action :authenticate_user!

  def dashboard
    @leave = LeaveApplication.new
    leave_approval = User.where(hod_email: current_user.email)
    @unapprove_leave = LeaveApplication.where(approved: 'N/A').includes(:user).where("
      users.hod_email = ?" , "#{current_user.email}").references(:users)
    @leave_id = @unapprove_leave.count
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(update_params)
    user.password = '123123'
    user.password_confirmation = '123123'
    if user.save
      UserMailer.create_user(user).deliver_later
      flash[:notice] = "#{user.email} was successfully created"
    else
      flash[:notice] = "The #{user.errors.full_messages[0]} while creating user #{user.email}"
    end
    redirect_to root_path
  end

  def index
    @users = User.order(:email)
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

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:notice] = "#{user.email} has been deleted"
    else
      error = user.errors.messages
      flash[:notice] = "#{error}"
    end

    redirect_to users_path
  end

  private

  def update_params
    params.require(:user).permit(:email, :title, :total_al, :replacement_leave, :bring_forward)
  end

end
