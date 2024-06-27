class AddLastSeenToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :last_seen, :datetime
  end
end
