class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with :not_authorised
  # before_action :authorised

  # helper_method :current_user
  # helper_method :logged_in?
  # helper_method :logged_out?
  # helper_method :logged_in_as_admin?

  def current_user
    @current_user ||= User.find(payload['user_id'])
  end

  # def logged_in?
  #   current_user.present?
  # end

  # def logged_out?
  #   !logged_in?
  # end

  # def logged_in_as_admin?
  #   logged_in? && current_user.is_admin?
  # end

  # protected

  # def authorised
  #   redirect_to login_path unless logged_in?
  # end

  private

  def not_authorised
    render json: { error: 'Not authorised' }, status: :unauthorized
  end
end