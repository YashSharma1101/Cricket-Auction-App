class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :gender
      t.string :contact_no
      t.text :skills
      t.string :level_of_skill
      t.string :interested_commentary
      t.string :interested_umpire
      t.string :interested_captaincy
      t.string :interested_managment
      t.string :team_name
      t.string :photo
      t.text :suggestions

      t.timestamps
    end
  end
end
