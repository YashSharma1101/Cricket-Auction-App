class AddCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :count, :integer, default: 0
  end
end
