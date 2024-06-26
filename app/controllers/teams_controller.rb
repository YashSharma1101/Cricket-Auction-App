class TeamsController < ApplicationController
  before_action :require_admin_login
  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def show
    @team = Team.find(params[:id])
  end

  def edit
    @team = Team.find(params[:id])
  end
  
  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to team_path(@team), notice: "Team #{@team.name} created."
    else
      render :new, notice: "Unable to create team #{@team.name}"
    end
  end

  def update
    @team = Team.find_by(id: params[:id])
    if @team.update(team_params)
      redirect_to team_path(@team), notice: "Team #{@team.name} data updated."
    else
    end
  end

  def destory
  end

  private

  def team_params
    params.require(:team).permit(:name, :purse, :total_players)
  end
end
