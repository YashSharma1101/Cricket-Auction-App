# app/controllers/admin_sessions_controller.rb
class AdminSessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.find_by(email: params[:email])
    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_dashboard_path
    else
      flash.now[:alert] = 
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    render :new
  end
end
