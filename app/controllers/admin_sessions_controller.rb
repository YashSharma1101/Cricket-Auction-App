# app/controllers/admin_sessions_controller.rb
class AdminSessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.find_by(email: params[:email])
    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_users_path
    else
      redirect_to new_admin_session_path, notice: "Wrong email/password."
      # flash.now[:alert] 
      # render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    render :new
  end

  def delete_admin
    admin = Admin.find_by(id: params[:admin_session_id])
    if admin.destroy
      redirect_to admin_session_path, notice: "Admin Deleted."
    else
      redirect_to admin_session_path, notice: "Unable to delete."
    end  
  end

  def index
    @admin = Admin.all
  end

  def show
    @admin = Admin.find(params[:id])
  end
end
