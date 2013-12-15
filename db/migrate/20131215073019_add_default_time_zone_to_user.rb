class AddDefaultTimeZoneToUser < ActiveRecord::Migration
  def change
    change_column_default :users, :time_zone, "UTC"
  end
end
