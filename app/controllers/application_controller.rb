class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    if not current_user
      redirect_to login_path, flash: { danger: "Whoa buddy, that page is off limits. Try logging in first. " }
    end
  end

end
