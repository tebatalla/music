class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find_by(session_token: session[:token])
  end

  def log_in_user!(user)
    user.reset_session_token!
    session[:token] = user.session_token
  end

  def logged_in?
    !current_user.nil?
  end

  def require_log_in
    unless logged_in?
      flash[:errors] = ["You must be logged in to see that page"]
      redirect_to new_session_url
    end
  end

  helper_method :current_user, :logged_in?
end
