class SessionsController < ApplicationController
  before_action :require_log_out, only: [:new, :create]
  before_action :require_log_in, only: :destroy

  def new

  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user] = @user.id
      flash[:success] = "You have successfully logged in!"
      redirect_to(root_path)
    else
      flash[:error] = "Could not log in.  Please check username and password."
      render(:new)
    end
  end

  def destroy
    session[:user] = nil
    flash[:success] = "You have successfully logged out!"
    redirect_to(root_path)
  end
end