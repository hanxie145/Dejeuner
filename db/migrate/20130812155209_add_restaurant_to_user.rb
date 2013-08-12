class AddRestaurantToUser < ActiveRecord::Migration
  def change
    add_column :users, :restaurant, :string
  end
end
