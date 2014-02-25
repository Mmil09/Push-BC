class UsersController < ApplicationController
  before_action :require_log_out, only: [:new, :create]
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_log_in, only: [:edit, :update]
  before_action only: [:edit, :update] { require_same_user(@user.id) }
  
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

  def edit
    
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account has been updated."
      redirect_to(user_path(@user))
    else
      flash[:error] = "There was an error in your input"
      render(:edit)
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end

  def set_user
    @user = User.find_by_slug(params[:id])
  end

end