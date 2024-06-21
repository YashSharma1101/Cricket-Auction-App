class Admin::DashboardController < ApplicationController
  before_action :require_admin_login

  def index
    @current_user= Admin.find_by(id: session[:admin_id])
    @user = User.all 
    @admin = Admin.all
  end

end
