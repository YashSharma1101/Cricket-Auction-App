class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.string :team1
      t.string :team2
      t.integer :t1_r
      t.float :t1_o
      t.integer :t2_r
      t.float :t2_o

      t.timestamps
    end
  end
end
