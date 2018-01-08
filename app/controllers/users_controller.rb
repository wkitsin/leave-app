class UsersController < ApplicationController

  before_action :authenticate_user!

  def dashboard
    @leave = Leave.new 
  end 

end
