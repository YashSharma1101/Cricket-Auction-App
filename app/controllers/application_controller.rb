class ApplicationController < ActionController::Base
  before_action :require_admin_login, if: :admin_request?
  before_action :check_session_expiration

  private

  def admin_request?
    controller_path.start_with?('admin/')
  end

  def require_admin_login
    
    redirect_to new_admin_session_path unless current_admin
  end

  # def current_admin
  #   @current_admin ||= Admin.find_by(id: session[:admin_id])
  # end

  def check_session_expiration
    if current_admin && session[:admin_id] && session_expired?
      reset_session
      redirect_to new_admin_session_path, alert: "Session has expired. Please log in again."
    elsif current_admin
      current_admin.update_last_seen
    end
  end

  def session_expired?
    current_admin&.last_seen < 5.hours.ago
  end

  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end
  helper_method :current_admin
end
