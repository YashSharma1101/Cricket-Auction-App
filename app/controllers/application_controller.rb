class ApplicationController < ActionController::Base
  before_action :require_admin_login, if: :admin_request?

  private

  def admin_request?
    controller_path.start_with?('admin/')
  end

  def require_admin_login
    
    redirect_to new_admin_session_path unless current_admin
  end

  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end
  helper_method :current_admin
end
