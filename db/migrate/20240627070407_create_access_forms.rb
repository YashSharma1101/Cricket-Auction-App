class CreateAccessForms < ActiveRecord::Migration[6.1]
  def change
    create_table :access_forms do |t|
      t.string :name
      t.string :email
      t.text :description

      t.timestamps
    end
  end
end
