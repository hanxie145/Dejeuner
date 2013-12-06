class AddCheckInCountToSmsContact < ActiveRecord::Migration
  def change
    add_column :sms_contacts, :check_in_count, :integer
  end
end
