class ApplicationController < ActionController::Base
  before_action :authorised

  helper_method :current_user
  helper_method :logged_in?
  helper_method :logged_in_as_admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def logged_in_as_admin?
    logged_in? && current_user.is_admin?
  end

  protected

  def authorised
    redirect_to login_path unless logged_in?
  end
end