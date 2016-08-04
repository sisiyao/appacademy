class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  helper_method :current_user

  def login(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def require_no_user!
    unless current_user.nil?
      redirect_to cats_url
    end
  end

  def require_user!
    if current_user.nil?
      redirect_to new_session_url
    end
  end

end
