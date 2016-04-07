class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_administrator

  def current_administrator
    @current_administrator ||= Administrator.find(session[:administrator_id]) if session[:administrator_id]
  end

  def require_administrator
    redirect_to login_path unless current_administrator
  end
end
