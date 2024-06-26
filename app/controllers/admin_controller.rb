class AdminController < ApplicationController
	def update
		@admin = Admin.find_by(id: params[:id])
		if @admin.update(admin_params)
			redirect_to admin_session_path(@admin), notice: "Updated"
		else
			redirect_to edit_admin_path(@admin), notice: "Unable to update!"
		end   
	end

	private

	def admin_params
		params.require(:admin).permit(:email, :password)
	end
end