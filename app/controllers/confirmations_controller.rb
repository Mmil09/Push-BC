class ConfirmationsController < ApplicationController
  before_action :set_user, :exists?

  def show
    if !@user.confirmed?
      @user.confirm
      flash[:success] = "Your account is now active!  Please sign in."
    else
      flash[:error] = "This account has already been confirmed.  Please sign in."
    end
    redirect_to(root_path)
  end

  private

  def set_user
    @user = User.find_by_confirmation_token(params[:token])
  end

  def exists?
    if @user == nil
      flash[:error] = "Could not confirm this account."
      redirect_to(root_path)
    end
  end





end