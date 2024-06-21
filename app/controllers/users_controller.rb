class UsersController < ApplicationController 
 skip_before_action :verify_authenticity_token
 before_action :require_admin_login, except: :home
  def index
  	@users = User.paginate(page: params[:page], per_page: 1)
    @player_number = 0
    @teams_with_latest_users = User.where.not(team: [nil, ""])
                                .group(:team)
                                .order('MAX(updated_at) DESC')
                                .pluck('MAX(updated_at) as latest_purchase_time, team, MAX(full_name) as latest_user_name, MAX(price) as latest_user_price')

    # @users_by_team = User.where.not(team: nil)
    #                  .group(:team)
    #                  .order('team, MAX(updated_at) DESC')
    #                  .pluck('team, MAX(updated_at) as latest_purchase_time, GROUP_CONCAT(full_name) as user_names, GROUP_CONCAT(price) as user_prices')

    @users_by_team = User.where.not(team: nil)
                     .group(:team)
                     .order('team, MAX(updated_at) DESC')
                     .select('team, MAX(updated_at) as latest_purchase_time, STRING_AGG(full_name, \', \') as user_names, STRING_AGG(price::text, \', \') as user_prices')

  end

  def import
    User.import(params[:file])
    redirect_to root_url #, notice: "Data imported successfully"
  end

  def associate_photos
    @users = User.all
  end

  def associate_photo
    @user = User.find(params[:id])
    if @user.photo_attachment.attach(params[:user][:photo_attachment])
    redirect_back(fallback_location: admin_users_path(query: params[:query]))
    else
      redirect_to admin_users_path
    end
    # redirect_to associate_photos_users_path, notice: "Photo associated successfully"
  end

  def create
    @user = User.new(user_params)
    @user.photo_attachment.attach(params[:user][:photo_attachment])
    if @user.save
      redirect_to admin_user_path(@user)
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if user_params["team"].blank?
      return redirect_to users_path(page: params[:page])
    end

    selected_team = Team.find_by(name: user_params["team"])

    if selected_team.blank?
      return redirect_to users_path(page: params[:page])
    end

    player_price = params[:user][:price].to_i

    if selected_team.purse < player_price
      flash[:alert] = "The selected team doesn't have enough purse reamaining to buy this player."
      return redirect_to users_path(page: params[:page], notice: "Not Have Enough Purse Balance to buy this player.")
    end

    if @user.update(user_params)
      selected_team.update(purse: selected_team.purse - player_price, total_players: selected_team.total_players+1)
    else
      flash[:alert] = 'Error updating player information.'
    end
    redirect_to users_path(page: params[:page])
  end

  def teams_data
    @data = []
    @users = User.all
    @teams = Team.all
    # @teams.each do |team|
    #   @data << User.where(team: team.name)
    # end
  end

  def send_mail
    byebug
    # @user = User.all
    # @user.each do |user| 
      user = User.find_by(email: "yashsharma0787@gmail.in")
      byebug
      if user.price == 0 && user.email.present?
        AuctionMailer.player_report(user).deliver_later
      end
    # end
  end
  

  def home
      
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :gender, :contact_no, :skills, :level_of_skill, :interested_commentary, :interested_umpire, :interested_captaincy, :interested_managment, :team_name, :photo_attachment, :suggestions, :team, :price, :email)
  end
end
