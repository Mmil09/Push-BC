class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    session[:user] ||= nil
  end

  def logged_in?
    !!current_user
  end

  def require_log_in
    if !logged_in?
      redirect_unauthorized_user
    end
  end

  def require_log_out
    if logged_in?
      redirect_unauthorized_user
    end
  end

  def admin?
    user = return_current_user
    true if user.is_a?(Admin)
  end

  def require_admin
    redirect_unauthorized_user if !admin?
  end

  def same_user?(id)
    true if current_user == id
  end

  def require_same_user(id)
    require_admin if !same_user?(id)
  end

  def is_bc_admin?(bootcamp)
    user = return_current_user
    require_admin if !user.is_bc_admin?(bootcamp.id)
  end

  def redirect_unauthorized_user
    flash[:error] = "You are not authorized to go there."
    redirect_to(root_path)
  end

  def return_current_user
    User.find(current_user)
  end



end
