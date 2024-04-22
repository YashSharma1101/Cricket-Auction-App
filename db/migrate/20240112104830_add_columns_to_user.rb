class AddColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :team, :string
    add_column :users, :price, :integer
  end
end
