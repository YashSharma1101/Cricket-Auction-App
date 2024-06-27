class AddContactNumberToAccessForm < ActiveRecord::Migration[6.1]
  def change
    add_column :access_forms, :contact_number, :integer
  end
end
