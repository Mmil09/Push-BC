class UsersController < ApplicationController
  before_action :require_log_out, only: [:new, :create]
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_log_in, only: [:edit, :update]
  before_action only: [:edit, :update] { require_same_user(@user.id) }
  
  def new
    add_breadcrumb "Sign Up", new_user_path
    @user = User.new
    render(:new)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.confirmation_email(@user).deliver
      flash[:success] = "A confirmation email has been sent.  You must confirm your account before signing in."
      redirect_to(root_path)
    else
      flash[:error] = "There were some errors."
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
    params.require(:user).permit(:username, :password, :email, :password_confirmation)
  end

  def set_user
    @user = User.find_by_slug(params[:id])
  end

end