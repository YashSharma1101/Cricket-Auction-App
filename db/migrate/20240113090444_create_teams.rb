class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :purse
      t.integer :total_players

      t.timestamps
    end
  end
end
