module Macros
  def end_user_session
    session[:user] = nil
  end

  def current_user(a_user=nil)
    user = a_user || Fabricate(:user)
    session[:user] = user.id
  end

end