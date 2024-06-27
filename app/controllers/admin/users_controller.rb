class Admin::UsersController < ApplicationController
  before_action :require_admin_login, except: [:access_form, :view_access_form]
  skip_before_action :verify_authenticity_token

  def index
    @admin = Admin.find_by(id: session[:admin_id])
    @users = User.paginate(page: params[:page], per_page: 7)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully destroyed.'
  end

  def update_full_name
    @user = User.find(params[:id])
    if @user.update(full_name: params["user"]["full_name"])
      redirect_back(fallback_location: admin_users_path(query: params[:query]))
    else
      redirect_to admin_users_path
    end
  end

  def update_email
    @user = User.find(params[:id])
    if @user.update(email: params["user"]["email"])
      redirect_back(fallback_location: admin_users_path(query: params[:query]))
      # redirect_to admin_users_path
    else
      redirect_to admin_users_path
    end
  end

  def update_skill
    @user = User.find(params[:id])
    if @user.update(skills: params["user"]["skills"])
      redirect_back(fallback_location: admin_users_path(query: params[:query]))
    else
      redirect_to admin_users_path
    end
  end

  def update_level
    @user = User.find(params[:id])
    if @user.update(level_of_skill: params["user"]["level_of_skill"])
      redirect_back(fallback_location: admin_users_path(query: params[:query]))
    else
      redirect_to admin_users_path
    end
  end

  def associate_photo
    @user = User.find(params[:id])
    @user.photo_attachment.attach(params[:user][:photo_attachment])
    redirect_to associate_photos_users_path, notice: "Photo associated successfully."
  end

  def search
    return redirect_to admin_users_path if params[:query]==""
    users = User.paginate(page: params[:page], per_page: 5)
    @admin = Admin.find_by(id: session[:admin_id])
    @query = params[:query]
    #@users = users.where("full_name LIKE ?", "%#{@query}%")
    @users = users.where("full_name ILIKE ?", "%#{@query}%")
    render :index
  end

  def view_access_form
    @access_form = AccessForm.new
  end

  def access_form
    @access_form = AccessForm.new(access_params)
    if @access_form.save
      AccessFormMailer.new_access_form(@access_form).deliver_now
      flash[:success] = "Your access request submitted successfully."
    else
      flash[:error] = "There was an error submitting your request. Please try again."
    end
    render :view_access_form
  end

  private


  def require_admin_login
    redirect_to new_admin_session_path unless current_admin
  end

  def user_params
    params.require(:user).permit(:full_name, :email, :skills, :level_of_skill, :team, :gender, :photo_attachment)
  end

  def access_params
    params.permit(:name, :email, :description)
  end
end
