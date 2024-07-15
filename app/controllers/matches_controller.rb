class MatchesController < ApplicationController

  def index
    @matches = Match.all
    @teams = Team.order(points: :desc, matches_won: :desc, nrr: :desc)
  end

  def new 
    @match = Match.new
  end
  
  def create
    @match = Match.new(match_params)
    @team1 = Team.find_by(name: @match&.team1)
    @team2 = Team.find_by(name: @match&.team2)
    
    if @match.t1_r > @match.t2_r
      @winner = @team1
      @losser = @team2
      @w_r = @match.t1_r
      @w_o = @match.t1_o
      @l_r = @match.t2_r
      @l_o = @match.t2_o
    elsif @match.t1_r < @match.t2_r
      @winner = @team2
      @losser = @team1
      @w_r = @match.t2_r
      @w_o = @match.t2_o
      @l_r = @match.t1_r
      @l_o = @match.t1_o
    end

    @winner.update(
      matches_played: @winner&.matches_played.to_i + 1,
      matches_won: @winner&.matches_won.to_i + 1,
      runs_scored: @winner&.runs_scored.to_i + @w_r,
      runs_given: @winner&.runs_given.to_i + @l_r,
      overs_bowled: @winner&.overs_bowled + @l_o,
      overs_played: @winner&.overs_played + @w_o,
      points: @winner&.points.to_i + 2
    )

    @losser.update(
      matches_played: @losser&.matches_played.to_i + 1,
      matches_lost: @losser&.matches_lost.to_i + 1,
      runs_scored: @losser&.runs_scored.to_i + @l_r,
      runs_given: @losser&.runs_given.to_i + @w_r,
      overs_bowled: @losser&.overs_bowled + @w_o,
      overs_played: @losser&.overs_played + @l_o
    )

    @winner.update(nrr: (@winner&.runs_scored.to_f / @winner&.overs_played) - (@winner&.runs_given.to_f / @winner&.overs_bowled))
    @losser.update(nrr: (@losser&.runs_scored.to_f / @losser&.overs_played) - (@losser&.runs_given.to_f / @losser&.overs_bowled))

    if @winner&.save && @losser&.save && @match&.save
      redirect_to matches_path, notice: "Match created successfully"
    else
      render :new, alert: "Error updating match and teams"
    end
  end


  def show
    @match = Match.find(params[:id])
    @team1 = Team.find_by(name: @match.team1)
    @team2 = Team.find_by(name: @match.team2)
  end


  def update
  end

  def delete
  end

  private

  def match_params
    params.require(:match).permit(:team1, :team2, :t1_r, :t1_o, :t2_r, :t2_o)
  end
end
