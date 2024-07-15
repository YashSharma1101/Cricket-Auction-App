class AddColumnsToTeams < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :matches_played, :string, default: '0'
    add_column :teams, :matches_won, :string, default: '0'
    add_column :teams, :matches_lost, :string, default: '0'
    add_column :teams, :runs_scored, :integer, default: 0
    add_column :teams, :runs_given, :integer, default: 0
    add_column :teams, :overs_played, :float, default: 0.0
    add_column :teams, :overs_bowled, :float, default: 0.0
    add_column :teams, :nrr, :float, default: 0.0
    add_column :teams, :points, :integer, default: 0
  end
end
