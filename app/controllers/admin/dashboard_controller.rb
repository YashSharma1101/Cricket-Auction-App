class Admin::DashboardController < ApplicationController
  before_action :require_admin_login

  def index
    @user = User.all 
  end
end
