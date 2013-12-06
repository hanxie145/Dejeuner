class AddCheckInCountToNumber < ActiveRecord::Migration
  def change
    add_column :numbers, :check_in_count, :integer
  end
end
