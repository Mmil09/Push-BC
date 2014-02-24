class UsersController < ApplicationController
  before_action :require_log_out, only: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user] = @user.id
      flash[:success] = "You are now registered and logged in."
      redirect_to(root_path)
    else
      flash[:error] = "There was an error.  Please check your input"
      render(:new)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end

end