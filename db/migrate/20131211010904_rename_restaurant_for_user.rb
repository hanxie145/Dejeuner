class RenameRestaurantForUser < ActiveRecord::Migration
  def change
    rename_column(:users, :restaurant, :business_name)
  end
end
