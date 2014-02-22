class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    session[:user] ||= nil
  end

  def is_admin?
    user = return_current_user
    if !user.is_a?(Admin)
      redirect_unauthorized_user
    end
  end

  def is_bc_admin?(bootcamp)
    user = return_current_user
    is_admin? if !user.is_bc_admin?(bootcamp.id)
  end

  def logged_in?
    if current_user == nil
      redirect_unauthorized_user
    end
  end

  def redirect_unauthorized_user
    flash[:error] = "You are not authorized to go there."
    redirect_to(root_path)
  end

  def return_current_user
    User.find(current_user)
  end

end
