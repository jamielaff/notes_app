class ApplicationController < ActionController::Base
  before_action :authorised

  helper_method :current_user
  helper_method :logged_in?
  helper_method :logged_in_as_admin?
  helper_method :authorised_for_user_actions?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def authorised
    redirect_to login_path unless logged_in?
  end

  def logged_in?
    current_user.present?
  end

  def logged_in_as_admin?
    current_user.present? && current_user.is_admin
  end

  def authorised_for_user_actions?
    unless logged_in_as_admin? || current_user == User.find(params[:id])
      flash[:danger] = "You are not authorised to perform that action"
      redirect_to root_path
    end
  end
end