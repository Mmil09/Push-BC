class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    session[:user] ||= nil
  end

  def is_admin?
    user = User.find(current_user)
    if user.type != "Admin"
      flash[:error] = "You are not authorized to go there."
      redirect_to(root_path)
    end
  end

  def logged_in?
    if current_user == nil
      flash[:error] = "You must be logged in to do that."
      redirect_to(root_path)
    end
  end

end
