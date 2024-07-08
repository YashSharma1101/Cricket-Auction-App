# app/controllers/admin_sessions_controller.rb
class AdminSessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.find_by(email: params[:email])
    if admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      admin.update_last_seen
      flash[:success] = "A new session has been started, you can now access the application."
      render :new
    else
      flash[:error] = "Wrong email/password."
      render :new
    end
  end
  

  def edit
    @admin = Admin.find_by(id: params[:id])
  end

  def destroy
    reset_session
    session[:admin_id] = nil
    redirect_to root_path, notice: "Logged out successfully, login again to access the application."
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

  def update
		@team = Team&.first
		@users = User.where(team: @team.name)
		if Team.update_all(purse: @team.purse + @users.sum(:price), total_players: 0) && User.update_all(team: nil, price: 0)
		  flash[:notice] = 'Success! the auction information has been reset.'
		else
		  flash[:alert] = 'Unable to reset auction data.'
		end
		redirect_to admin_sessions_path
	end
end
