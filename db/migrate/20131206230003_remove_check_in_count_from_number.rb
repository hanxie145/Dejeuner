class RemoveCheckInCountFromNumber < ActiveRecord::Migration
  def change
    remove_column :numbers, :check_in_count, :integer
  end
end
